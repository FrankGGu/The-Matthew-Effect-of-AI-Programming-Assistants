var minScoreTriangulation = function(values) {
    const n = values.length;
    const dp = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let len = 3; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;
            dp[i][j] = Infinity;
            for (let k = i + 1; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + values[i] * values[k] * values[j]);
            }
        }
    }

    return dp[0][n - 1];
};