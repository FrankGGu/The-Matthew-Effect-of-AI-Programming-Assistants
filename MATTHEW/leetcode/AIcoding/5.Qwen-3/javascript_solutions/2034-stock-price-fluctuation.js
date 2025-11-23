var StockPrice = function() {
    this.timeToPrice = new Map();
    this.maxTime = 0;
    this.priceHistory = new Map();
};

StockPrice.prototype.update = function(timestamp, price) {
    this.timeToPrice.set(timestamp, price);
    if (timestamp > this.maxTime) {
        this.maxTime = timestamp;
    }
    if (!this.priceHistory.has(price)) {
        this.priceHistory.set(price, 1);
    } else {
        this.priceHistory.set(price, this.priceHistory.get(price) + 1);
    }
};

StockPrice.prototype.current = function() {
    return this.timeToPrice.get(this.maxTime);
};

StockPrice.prototype.maximum = function() {
    let maxPrice = -Infinity;
    for (let [price, count] of this.priceHistory.entries()) {
        if (count > 0 && price > maxPrice) {
            maxPrice = price;
        }
    }
    return maxPrice;
};

StockPrice.prototype.minimum = function() {
    let minPrice = Infinity;
    for (let [price, count] of this.priceHistory.entries()) {
        if (count > 0 && price < minPrice) {
            minPrice = price;
        }
    }
    return minPrice;
};