class Cashier {
    constructor(n, discount, products, prices) {
        this.n = n;
        this.discount = discount;
        this.productPrices = {};
        for (let i = 0; i < products.length; i++) {
            this.productPrices[products[i]] = prices[i];
        }
        this.customerCount = 0;
    }

    getBill(product, amount) {
        this.customerCount++;
        let total = 0;
        for (let i = 0; i < product.length; i++) {
            total += this.productPrices[product[i]] * amount[i];
        }
        if (this.customerCount % this.n === 0) {
            total = total * (1 - this.discount / 100);
        }
        return total;
    }
}