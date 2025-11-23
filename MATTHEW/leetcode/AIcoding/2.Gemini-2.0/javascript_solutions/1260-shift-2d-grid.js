var shiftGrid = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    k = k % (m * n);

    const result = Array(m).fill(null).map(() => Array(n));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let newIndex = (i * n + j + k) % (m * n);
            let newRow = Math.floor(newIndex / n);
            let newCol = newIndex % n;
            result[newRow][newCol] = grid[i][j];
        }
    }

    return result;
};