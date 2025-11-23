var rangeAddQueries = function(n, queries) {
    let grid = Array(n).fill(0).map(() => Array(n).fill(0));

    for (const [r1, c1, r2, c2] of queries) {
        grid[r1][c1]++;
        if (c2 + 1 < n) {
            grid[r1][c2 + 1]--;
        }
        if (r2 + 1 < n) {
            grid[r2 + 1][c1]--;
        }
        if (r2 + 1 < n && c2 + 1 < n) {
            grid[r2 + 1][c2 + 1]++;
        }
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i > 0) {
                grid[i][j] += grid[i - 1][j];
            }
            if (j > 0) {
                grid[i][j] += grid[i][j - 1];
            }
            if (i > 0 && j > 0) {
                grid[i][j] -= grid[i - 1][j - 1];
            }
        }
    }

    return grid;
};