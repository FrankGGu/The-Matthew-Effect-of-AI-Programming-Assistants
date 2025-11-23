class StockSpanner {
    constructor() {
        this.prices = [];
        this.spans = [];
    }

    next(price) {
        let span = 1;
        while (this.prices.length > 0 && this.prices[this.prices.length - 1] <= price) {
            this.prices.pop();
            span += this.spans.pop();
        }
        this.prices.push(price);
        this.spans.push(span);
        return span;
    }
}