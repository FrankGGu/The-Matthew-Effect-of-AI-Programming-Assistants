var countPaths = function(grid, k) {
    const m = grid.length, n = grid[0].length;
    const mod = new Array(m).fill(0).map(() => new Array(n).fill(0).map(() => new Array(k).fill(0)));
    mod[0][0][grid[0][0] % k] = 1;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            for (let r = 0; r < k; r++) {
                if (i > 0) mod[i][j][r] += mod[i - 1][j][r];
                if (j > 0) mod[i][j][r] += mod[i][j - 1][r];
                mod[i][j][(r + grid[i][j]) % k] += mod[i][j][r];
            }
        }
    }

    return mod[m - 1][n - 1][0];
};