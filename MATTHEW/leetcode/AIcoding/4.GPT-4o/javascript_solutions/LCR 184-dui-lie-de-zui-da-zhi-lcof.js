class Cashier {
    constructor(n, money, products, prices) {
        this.number = n;
        this.money = money;
        this.products = new Map();
        for (let i = 0; i < products.length; i++) {
            this.products.set(products[i], prices[i]);
        }
        this.count = 0;
    }

    getBill(product, amount) {
        let total = 0;
        for (let i = 0; i < product.length; i++) {
            total += this.products.get(product[i]) * amount[i];
        }
        return total;
    }

    checkout(product, amount) {
        this.count++;
        let total = this.getBill(product, amount);
        let change = this.money - total;
        if (change < 0 || (this.count % this.number === 0 && change !== 0)) {
            return -1;
        }
        return change;
    }
}