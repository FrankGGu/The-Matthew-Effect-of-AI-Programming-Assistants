var ProductOfTheLastKNumbers = function(nums) {
    this.prefix = [1];
    for (let num of nums) {
        this.prefix.push(this.prefix[this.prefix.length - 1] * num);
    }
};

ProductOfTheLastKNumbers.prototype.add = function(num) {
    this.prefix.push(this.prefix[this.prefix.length - 1] * num);
};

ProductOfTheLastKNumbers.prototype.getProduct = function(k) {
    return this.prefix[this.prefix.length - 1] / this.prefix[this.prefix.length - k - 1];
};