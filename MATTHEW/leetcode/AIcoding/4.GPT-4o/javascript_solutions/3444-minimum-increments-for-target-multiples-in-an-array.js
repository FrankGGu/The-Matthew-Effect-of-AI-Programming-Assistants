var minIncrements = function(n, cost, target) {
    const dp = new Array(target + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        for (let j = target; j >= cost[i]; j--) {
            dp[j] = Math.min(dp[j], dp[j - cost[i]] + cost[i]);
        }
    }

    return dp[target] === Infinity ? -1 : dp[target];
};