function sellingWood(m, n) {
    const dp = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = i * j;
            for (let k = 1; k < i; k++) {
                dp[i][j] = Math.max(dp[i][j], dp[k][j] + dp[i - k][j]);
            }
            for (let l = 1; l < j; l++) {
                dp[i][j] = Math.max(dp[i][j], dp[i][l] + dp[i][j - l]);
            }
        }
    }

    return dp[m][n];
}