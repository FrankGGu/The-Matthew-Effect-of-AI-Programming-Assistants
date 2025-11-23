var pushCount = function(words) {
    const n = words.length;
    const m = words[0].length;
    const dp = Array(n + 1).fill().map(() => Array(m + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 0; i <= n; i++) {
        for (let j = 0; j <= m; j++) {
            if (i < n) {
                dp[i + 1][j] = Math.min(dp[i + 1][j], dp[i][j] + 1);
            }
            if (j < m) {
                dp[i][j + 1] = Math.min(dp[i][j + 1], dp[i][j] + 1);
            }
            if (i < n && j < m && words[i][j] === words[0][j]) {
                dp[i + 1][j + 1] = Math.min(dp[i + 1][j + 1], dp[i][j]);
            }
        }
    }
    return dp[n][m];
};