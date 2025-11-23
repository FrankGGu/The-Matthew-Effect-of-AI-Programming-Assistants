var Chaining = function() {
    this.value = 0;
};

Chaining.prototype.add = function(num) {
    this.value += num;
    return this;
};

Chaining.prototype.subtract = function(num) {
    this.value -= num;
    return this;
};

Chaining.prototype.multiply = function(num) {
    this.value *= num;
    return this;
};

Chaining.prototype.divide = function(num) {
    this.value = Math.floor(this.value / num);
    return this;
};

Chaining.prototype.getValue = function() {
    return this.value;
};