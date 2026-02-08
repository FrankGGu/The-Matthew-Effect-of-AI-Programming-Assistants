var tilingRectangle = function(n, m) {
    const dp = Array.from({ length: n + 1 }, () => Array(m + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            for (let k = 1; k <= Math.min(i, j); k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i - k][j] + dp[k][j - k] + 1);
            }
            for (let k = 1; k < i; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[k][j] + dp[i - k][j]);
            }
            for (let k = 1; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[i][j - k]);
            }
        }
    }
    return dp[n][m];
};