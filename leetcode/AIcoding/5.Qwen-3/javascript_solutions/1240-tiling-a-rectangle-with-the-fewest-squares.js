var tilingRectangle = function(n, m) {
    const dp = Array.from({ length: n + 1 }, () => Array(m + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            if (i === j) {
                dp[i][j] = 1;
            } else {
                dp[i][j] = Infinity;
                for (let k = 1; k < i; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[k][j] + dp[i - k][j]);
                }
                for (let k = 1; k < j; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[i][j - k]);
                }
                for (let k = 1; k < i; k++) {
                    for (let l = 1; l < j; l++) {
                        dp[i][j] = Math.min(dp[i][j], dp[k][l] + dp[i - k][l] + dp[k][j - l] + dp[i - k][j - l]);
                    }
                }
            }
        }
    }

    return dp[n][m];
};