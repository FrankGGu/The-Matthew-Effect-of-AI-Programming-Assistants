function minCost(caption, words) {
    const n = caption.length, m = words.length;
    const dp = Array(n + 1).fill(0).map(() => Array(m + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        dp[i][0] = dp[i - 1][0] + 1;
    }

    for (let j = 1; j <= m; j++) {
        dp[0][j] = dp[0][j - 1] + 1;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            if (caption[i - 1] === words[j - 1]) {
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - 1]);
            }
            dp[i][j] = Math.min(dp[i][j], dp[i - 1][j] + 1, dp[i][j - 1] + 1);
        }
    }

    return dp[n][m];
}