var shiftGrid = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const total = m * n;
    k = k % total;
    if (k === 0) return grid;

    const res = new Array(m).fill().map(() => new Array(n).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const pos = (i * n + j + k) % total;
            const newRow = Math.floor(pos / n);
            const newCol = pos % n;
            res[newRow][newCol] = grid[i][j];
        }
    }
    return res;
};