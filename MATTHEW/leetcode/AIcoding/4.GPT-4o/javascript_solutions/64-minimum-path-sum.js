var minPathSum = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) continue;
            let fromTop = i > 0 ? grid[i - 1][j] : Infinity;
            let fromLeft = j > 0 ? grid[i][j - 1] : Infinity;
            grid[i][j] += Math.min(fromTop, fromLeft);
        }
    }

    return grid[m - 1][n - 1];
};