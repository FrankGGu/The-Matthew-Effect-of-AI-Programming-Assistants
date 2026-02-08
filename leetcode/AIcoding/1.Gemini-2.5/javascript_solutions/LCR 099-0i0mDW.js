var minPathSum = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) {
                // Starting point, no change needed
                continue;
            } else if (i === 0) {
                // First row, can only come from the left
                grid[i][j] += grid[i][j - 1];
            } else if (j === 0) {
                // First column, can only come from above
                grid[i][j] += grid[i - 1][j];
            } else {
                // General case, can come from above or left
                grid[i][j] += Math.min(grid[i - 1][j], grid[i][j - 1]);
            }
        }
    }

    return grid[m - 1][n - 1];
};