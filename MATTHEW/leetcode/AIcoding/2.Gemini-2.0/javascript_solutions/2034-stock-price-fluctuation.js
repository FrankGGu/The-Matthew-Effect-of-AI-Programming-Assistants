var StockPrice = function() {
    this.prices = new Map();
    this.maxTimestamp = 0;
    this.minHeap = [];
    this.maxHeap = [];
};

StockPrice.prototype.update = function(timestamp, price) {
    this.prices.set(timestamp, price);
    this.maxTimestamp = Math.max(this.maxTimestamp, timestamp);
    this.minHeap.push([price, timestamp]);
    this.maxHeap.push([-price, timestamp]);
    this.minHeap.sort((a, b) => a[0] - b[0]);
    this.maxHeap.sort((a, b) => b[0] - a[0]);
};

StockPrice.prototype.current = function() {
    return this.prices.get(this.maxTimestamp);
};

StockPrice.prototype.maximum = function() {
    while (this.maxHeap.length > 0) {
        const [price, timestamp] = this.maxHeap[0];
        const actualPrice = this.prices.get(timestamp);
        if (-price === actualPrice) {
            return -price;
        } else {
            this.maxHeap.shift();
        }
    }
    return -1;
};

StockPrice.prototype.minimum = function() {
    while (this.minHeap.length > 0) {
        const [price, timestamp] = this.minHeap[0];
        const actualPrice = this.prices.get(timestamp);
        if (price === actualPrice) {
            return price;
        } else {
            this.minHeap.shift();
        }
    }
    return -1;
};