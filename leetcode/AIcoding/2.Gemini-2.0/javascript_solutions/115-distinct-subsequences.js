var numDistinct = function(s, t) {
    const m = s.length;
    const n = t.length;

    const dp = Array(n + 1).fill(null).map(() => Array(m + 1).fill(0));

    for (let j = 0; j <= m; j++) {
        dp[0][j] = 1;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            if (t[i - 1] === s[j - 1]) {
                dp[i][j] = dp[i - 1][j - 1] + dp[i][j - 1];
            } else {
                dp[i][j] = dp[i][j - 1];
            }
        }
    }

    return dp[n][m];
};