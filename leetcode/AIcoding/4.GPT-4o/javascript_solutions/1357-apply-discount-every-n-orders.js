class Cashier {
    constructor(n, discount, products, prices) {
        this.n = n;
        this.discount = discount;
        this.products = new Map();
        for (let i = 0; i < products.length; i++) {
            this.products.set(products[i], prices[i]);
        }
        this.count = 0;
    }

    getBill(cart) {
        let total = 0;
        for (let product of cart) {
            total += this.products.get(product);
        }
        this.count++;
        if (this.count % this.n === 0) {
            total -= (total * this.discount) / 100;
        }
        return total;
    }
}