var minIncrements = function(n, cost, target) {
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < cost.length; j++) {
            if (i - cost[j] >= 0) {
                dp[i] = Math.min(dp[i], dp[i - cost[j]] + 1);
            }
        }
    }

    return dp[target] === Infinity ? -1 : dp[target];
};