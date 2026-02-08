var connectTwoGroups = function(cost) {
    const m = cost.length;
    const n = cost[0].length;
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < m; i++) {
        const nextDp = new Array(1 << n).fill(Infinity);
        for (let mask = 0; mask < (1 << n); mask++) {
            for (let j = 0; j < n; j++) {
                nextDp[mask | (1 << j)] = Math.min(nextDp[mask | (1 << j)], dp[mask] + cost[i][j]);
            }
            nextDp[mask] = Math.min(nextDp[mask], dp[mask]);
        }
        dp.fill(Infinity);
        for(let mask = 0; mask < (1<<n); mask++){
            dp[mask] = nextDp[mask];
        }

    }
    return dp[(1 << n) - 1];
};