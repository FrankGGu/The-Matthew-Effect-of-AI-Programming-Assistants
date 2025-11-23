var NeighborSum = function(grid) {
    this.grid = grid;
    this.rows = grid.length;
    this.cols = grid[0].length;
    this.map = new Map();

    for (let r = 0; r < this.rows; r++) {
        for (let c = 0; c < this.cols; c++) {
            this.map.set(grid[r][c], [r, c]);
        }
    }
};

NeighborSum.prototype.get = function(value) {
    const [r, c] = this.map.get(value);
    let sum = 0;

    if (r > 0) sum += this.grid[r - 1][c];
    if (r < this.rows - 1) sum += this.grid[r + 1][c];
    if (c > 0) sum += this.grid[r][c - 1];
    if (c < this.cols - 1) sum += this.grid[r][c + 1];

    return sum;
};