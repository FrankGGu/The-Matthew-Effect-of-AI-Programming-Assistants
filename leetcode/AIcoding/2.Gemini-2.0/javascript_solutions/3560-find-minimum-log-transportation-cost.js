var minCost = function(logs, n) {
    const dp = new Array(n + 1).fill(Infinity);
    dp[1] = 0;

    for (let i = 0; i < logs.length; i++) {
        const [start, end, cost] = logs[i];
        for (let j = 1; j <= n; j++) {
            if (j >= start) {
                dp[end] = Math.min(dp[end], dp[j] + cost);
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};