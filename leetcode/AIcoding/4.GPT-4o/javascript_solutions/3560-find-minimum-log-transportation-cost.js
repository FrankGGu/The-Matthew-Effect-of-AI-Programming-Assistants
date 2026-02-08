function minCostToTransportLog(cost, k) {
    const n = cost.length;
    if (n === 0) return 0;

    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= Math.min(i, k); j++) {
            let sum = 0;
            for (let m = i; m >= 1; m--) {
                sum += cost[m - 1];
                dp[i][j] = Math.min(dp[i][j], dp[m - 1][j - 1] + sum);
            }
        }
    }

    return dp[n][k];
}