# Use NodeJS base image
FROM xthian82/docker-ionic as ionic

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

COPY ionic.config.json ./

# Install dependencies
RUN npm install

# Copy app source
COPY . .
RUN ionic build

## Run
FROM nginx:alpine

#COPY www /usr/share/nginx/html
COPY --from=ionic  /usr/src/app/www /usr/share/nginx/html
