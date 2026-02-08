class StockPrice {
    constructor() {
        this.timestampPriceMap = new Map();
        this.prices = [];
        this.latestTimestamp = 0;
    }

    update(timestamp, price) {
        if (this.timestampPriceMap.has(timestamp)) {
            const index = this.timestampPriceMap.get(timestamp);
            this.prices[index] = price;
        } else {
            this.timestampPriceMap.set(timestamp, this.prices.length);
            this.prices.push(price);
        }
        this.latestTimestamp = Math.max(this.latestTimestamp, timestamp);
    }

    current() {
        return this.prices[this.timestampPriceMap.get(this.latestTimestamp)];
    }

    maximum() {
        return Math.max(...this.prices);
    }

    minimum() {
        return Math.min(...this.prices);
    }
}