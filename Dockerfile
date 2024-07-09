FROM golang:1.20.5-alpine3.17 AS builder
RUN apk add --no-cache git
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build

FROM alpine:3.18.3
ENV MY_CONFIG_PATH=/genesis.conf
COPY genesis.conf /genesis.conf 
COPY --from=builder /src/backend-scraper /backend-scraper
ENTRYPOINT [ "/backend-scraper" ]
