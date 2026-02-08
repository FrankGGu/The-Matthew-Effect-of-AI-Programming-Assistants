var Solution = function(m, n) {
    this.m = m;
    this.n = n;
    this.total = m * n;
    this.map = new Map();
};

Solution.prototype.flip = function() {
    let r_idx = Math.floor(Math.random() * this.total);

    let linear_idx_to_flip = this.map.has(r_idx) ? this.map.get(r_idx) : r_idx;

    let last_conceptual_idx = this.total - 1;
    let linear_idx_at_end = this.map.has(last_conceptual_idx) ? this.map.get(last_conceptual_idx) : last_conceptual_idx;

    this.map.set(r_idx, linear_idx_at_end);

    this.total--;

    let row = Math.floor(linear_idx_to_flip / this.n);
    let col = linear_idx_to_flip % this.n;

    return [row, col];
};

Solution.prototype.reset = function() {
    this.total = this.m * this.n;
    this.map.clear();
};