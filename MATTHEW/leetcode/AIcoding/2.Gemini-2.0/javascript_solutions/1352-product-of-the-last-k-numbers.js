var ProductOfNumbers = function() {
    this.prefixProducts = [1];
};

ProductOfNumbers.prototype.add = function(num) {
    if (num === 0) {
        this.prefixProducts = [1];
    } else {
        this.prefixProducts.push(this.prefixProducts[this.prefixProducts.length - 1] * num);
    }
};

ProductOfNumbers.prototype.getProduct = function(k) {
    if (k >= this.prefixProducts.length) {
        return 0;
    }
    const n = this.prefixProducts.length;
    return this.prefixProducts[n - 1] / this.prefixProducts[n - 1 - k];
};