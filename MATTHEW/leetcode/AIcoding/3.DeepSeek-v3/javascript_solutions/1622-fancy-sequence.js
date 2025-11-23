var Fancy = function() {
    this.sequence = [];
    this.ops = [];
    this.mod = 1e9 + 7;
};

Fancy.prototype.append = function(val) {
    this.sequence.push(val);
    this.ops.push([1, 0]);
};

Fancy.prototype.addAll = function(inc) {
    this.ops.push([1, inc]);
};

Fancy.prototype.multAll = function(m) {
    this.ops.push([m, 0]);
};

Fancy.prototype.getIndex = function(idx) {
    if (idx >= this.sequence.length) return -1;
    let val = this.sequence[idx];
    for (let i = 0; i < this.ops.length; i++) {
        const [a, b] = this.ops[i];
        val = (val * a + b) % this.mod;
    }
    return val;
};