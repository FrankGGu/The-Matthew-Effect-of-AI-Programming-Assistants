class Cashier {
    constructor(n, discount, products) {
        this.n = n;
        this.discount = discount;
        this.productPrices = new Map();
        for (const [id, price] of products) {
            this.productPrices.set(id, price);
        }
        this.orderCount = 0;
    }

    getBill(product, amount) {
        this.orderCount++;
        let currentBill = 0;
        for (let i = 0; i < product.length; i++) {
            const productId = product[i];
            const productAmount = amount[i];
            currentBill += this.productPrices.get(productId) * productAmount;
        }

        if (this.orderCount % this.n === 0) {
            currentBill *= (1 - this.discount / 100);
        }

        return currentBill;
    }
}