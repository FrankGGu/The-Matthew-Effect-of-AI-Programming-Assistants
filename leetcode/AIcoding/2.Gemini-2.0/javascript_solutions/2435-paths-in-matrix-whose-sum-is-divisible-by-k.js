var numberOfPaths = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const MOD = 10**9 + 7;

    let dp = Array(m).fill(null).map(() => Array(n).fill(null).map(() => Array(k).fill(0)));

    dp[0][0][grid[0][0] % k] = 1;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            for (let rem = 0; rem < k; rem++) {
                if (i > 0) {
                    dp[i][j][(rem + grid[i][j]) % k] = (dp[i][j][(rem + grid[i][j]) % k] + dp[i - 1][j][rem]) % MOD;
                }
                if (j > 0) {
                    dp[i][j][(rem + grid[i][j]) % k] = (dp[i][j][(rem + grid[i][j]) % k] + dp[i][j - 1][rem]) % MOD;
                }
            }
        }
    }

    return dp[m - 1][n - 1][0];
};