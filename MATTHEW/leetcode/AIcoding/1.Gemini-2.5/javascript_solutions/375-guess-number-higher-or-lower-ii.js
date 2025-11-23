var getMoneyAmount = function(n) {
    const dp = Array(n + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let len = 2; len <= n; len++) {
        for (let i = 1; i <= n - len + 1; i++) {
            const j = i + len - 1;
            dp[i][j] = Infinity;

            for (let k = i; k <= j; k++) {
                let cost = k;
                const costIfLower = (k > i) ? dp[i][k - 1] : 0;
                const costIfHigher = (k < j) ? dp[k + 1][j] : 0;

                cost += Math.max(costIfLower, costIfHigher);
                dp[i][j] = Math.min(dp[i][j], cost);
            }
        }
    }

    return dp[1][n];
};