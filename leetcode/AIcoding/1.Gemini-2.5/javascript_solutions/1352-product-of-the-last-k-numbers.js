class ProductOfNumbers {
    constructor() {
        this.prefixProducts = [1];
    }

    add(num) {
        if (num === 0) {
            this.prefixProducts = [1];
        } else {
            this.prefixProducts.push(this.prefixProducts.at(-1) * num);
        }
    }

    getProduct(k) {
        if (k >= this.prefixProducts.length) {
            return 0;
        } else {
            return this.prefixProducts.at(-1) / this.prefixProducts.at(-k - 1);
        }
    }
}