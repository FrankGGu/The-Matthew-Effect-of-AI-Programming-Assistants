class ProductOfNumbers {
    constructor() {
        this.products = [1];
    }

    add(num) {
        if (num === 0) {
            this.products = [1];
        } else {
            this.products.push(this.products[this.products.length - 1] * num);
        }
    }

    getProduct(k) {
        if (k >= this.products.length) return 0;
        return this.products[this.products.length - 1] / this.products[this.products.length - 1 - k];
    }
}