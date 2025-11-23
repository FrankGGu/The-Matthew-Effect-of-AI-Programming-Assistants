var Fancy = function() {
    this.sequence = [];
    this.add = 0;
    this.mul = 1;
};

Fancy.prototype.append = function(x) {
    this.sequence.push((x - this.add) * this.mul);
};

Fancy.prototype.addAll = function(inc) {
    this.add += inc;
};

Fancy.prototype.multiplyAll = function(m) {
    this.mul *= m;
};

Fancy.prototype.getAtIndex = function(i) {
    return (this.sequence[i] / this.mul) + this.add;
};