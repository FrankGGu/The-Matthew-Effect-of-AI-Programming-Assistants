var maxProductPath = function(grid) {
    const MOD = 1e9 + 7;
    const m = grid.length, n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));
    const neg = Array.from({ length: m }, () => Array(n).fill(0));

    dp[0][0] = grid[0][0];
    neg[0][0] = grid[0][0] < 0 ? grid[0][0] : -Infinity;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) continue;
            const val = grid[i][j];

            if (i > 0) {
                if (dp[i - 1][j] > 0) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j] * val);
                    neg[i][j] = Math.min(neg[i][j], dp[i - 1][j] * val);
                } else {
                    neg[i][j] = Math.min(neg[i][j], neg[i - 1][j] * val);
                    if (neg[i - 1][j] < 0) {
                        dp[i][j] = Math.max(dp[i][j], neg[i - 1][j] * val);
                    }
                }
            }
            if (j > 0) {
                if (dp[i][j - 1] > 0) {
                    dp[i][j] = Math.max(dp[i][j], dp[i][j - 1] * val);
                    neg[i][j] = Math.min(neg[i][j], dp[i][j - 1] * val);
                } else {
                    neg[i][j] = Math.min(neg[i][j], neg[i][j - 1] * val);
                    if (neg[i][j - 1] < 0) {
                        dp[i][j] = Math.max(dp[i][j], neg[i][j - 1] * val);
                    }
                }
            }
        }
    }
    return dp[m - 1][n - 1] < 0 ? -1 : dp[m - 1][n - 1] % MOD;
};