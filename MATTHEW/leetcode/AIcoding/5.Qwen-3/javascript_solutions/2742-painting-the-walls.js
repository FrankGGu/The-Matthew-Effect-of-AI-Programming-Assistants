function minCostToPaintWalls(cost, time) {
    const n = cost.length;
    const dp = Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        for (let j = n; j >= 0; j--) {
            dp[j] = Math.min(dp[j], dp[Math.max(j - time[i] - 1, 0)] + cost[i]);
        }
    }
    return dp[n];
}