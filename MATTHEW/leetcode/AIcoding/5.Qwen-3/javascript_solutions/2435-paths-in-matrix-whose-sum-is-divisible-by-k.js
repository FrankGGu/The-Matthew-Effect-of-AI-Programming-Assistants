function numberOfPaths(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const MOD = 1000000007;

    const dp = new Array(m).fill(0).map(() => new Array(n).fill(0).map(() => new Array(k).fill(0)));

    dp[0][0][grid[0][0] % k] = 1;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) continue;
            for (let rem = 0; rem < k; rem++) {
                let prevRem = (rem - grid[i][j]) % k;
                if (prevRem < 0) prevRem += k;
                if (i > 0) {
                    dp[i][j][rem] = (dp[i][j][rem] + dp[i - 1][j][prevRem]) % MOD;
                }
                if (j > 0) {
                    dp[i][j][rem] = (dp[i][j][rem] + dp[i][j - 1][prevRem]) % MOD;
                }
            }
        }
    }

    return dp[m - 1][n - 1][0];
}