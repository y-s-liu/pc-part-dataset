# 步驟 1: 選擇一個包含完整作業系統工具的 Node.js 映像
# Puppeteer 需要一些 Alpine 映像中沒有的系統函式庫，因此我們選用 Debian-based 的 slim 版本
FROM node:22-bookworm-slim

# 步驟 2: 在容器中建立一個工作目錄
WORKDIR /usr/src/app

# 步驟 3: 複製 package.json 和 package-lock.json
# 這樣可以利用 Docker 的快取機制，只有在依賴項變更時才重新安裝
COPY package.json package-lock.json ./

# 步驟 4: 安裝專案依賴
# Puppeteer 在安裝時需要下載 Chromium，這會花一些時間
# 使用 npm ci 可以確保安裝與 package-lock.json 完全一致的版本
RUN npm ci

# 步驟 5: 複製專案的其餘程式碼
COPY . .

# 步驟 6: 設定容器啟動時的預設指令
CMD [ "npm", "start" ]
