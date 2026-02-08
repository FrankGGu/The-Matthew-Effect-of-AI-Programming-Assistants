var sellingWood = function(m, n, prices) {
    const dp = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (const [h, w, p] of prices) {
        if (h <= m && w <= n) {
            dp[h][w] = Math.max(dp[h][w], p);
        }
    }

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            // Consider horizontal cuts
            for (let k = 1; k < i; k++) {
                dp[i][j] = Math.max(dp[i][j], dp[k][j] + dp[i - k][j]);
            }
            // Consider vertical cuts
            for (let k = 1; k < j; k++) {
                dp[i][j] = Math.max(dp[i][j], dp[i][k] + dp[i][j - k]);
            }
        }
    }

    return dp[m][n];
};