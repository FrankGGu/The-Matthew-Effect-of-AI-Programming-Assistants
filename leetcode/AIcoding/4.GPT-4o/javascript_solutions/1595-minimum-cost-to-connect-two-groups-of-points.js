var connectTwoGroups = function(cost) {
    const n = cost.length, m = cost[0].length;
    const dp = Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let j = 0; j < m; j++) {
        const newDp = Array(1 << n).fill(Infinity);
        for (let mask = 0; mask < (1 << n); mask++) {
            for (let i = 0; i < n; i++) {
                newDp[mask | (1 << i)] = Math.min(newDp[mask | (1 << i)], dp[mask] + cost[i][j]);
            }
        }
        dp = newDp;
    }

    return Math.min(...dp);
};