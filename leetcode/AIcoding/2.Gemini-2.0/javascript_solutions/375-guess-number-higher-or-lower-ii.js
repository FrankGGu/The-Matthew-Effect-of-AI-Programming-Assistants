var getMoneyAmount = function(n) {
    const dp = Array(n + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (let len = 2; len <= n; len++) {
        for (let i = 1; i <= n - len + 1; i++) {
            let j = i + len - 1;
            dp[i][j] = Infinity;
            for (let k = i; k <= j; k++) {
                let cost = k + Math.max(k - 1 >= i ? dp[i][k - 1] : 0, k + 1 <= j ? dp[k + 1][j] : 0);
                dp[i][j] = Math.min(dp[i][j], cost);
            }
        }
    }

    return dp[1][n];
};