var Solution = function(n_rows, n_cols) {
    this.rows = n_rows;
    this.cols = n_cols;
    this.total = n_rows * n_cols;
    this.map = new Map();
};

Solution.prototype.flip = function() {
    let rand = Math.floor(Math.random() * this.total);
    this.total--;

    let val = this.map.get(rand) || rand;
    this.map.set(rand, this.map.get(this.total) || this.total);

    let row = Math.floor(val / this.cols);
    let col = val % this.cols;
    return [row, col];
};

Solution.prototype.reset = function() {
    this.total = this.rows * this.cols;
    this.map = new Map();
};