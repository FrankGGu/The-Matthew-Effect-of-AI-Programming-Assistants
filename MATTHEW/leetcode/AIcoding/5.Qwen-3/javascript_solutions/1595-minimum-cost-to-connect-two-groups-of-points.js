function connectTwoGroups(cost) {
    const n = cost.length;
    const m = cost[0].length;
    const dp = new Array(1 << m).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        const nextDp = [...dp];
        for (let mask = 0; mask < (1 << m); mask++) {
            if (dp[mask] === Infinity) continue;
            for (let j = 0; j < m; j++) {
                if ((mask & (1 << j)) === 0) {
                    const newMask = mask | (1 << j);
                    nextDp[newMask] = Math.min(nextDp[newMask], dp[mask] + cost[i][j]);
                }
            }
        }
        dp.splice(0, dp.length, ...nextDp);
    }

    let result = Infinity;
    for (let mask = 0; mask < (1 << m); mask++) {
        if (dp[mask] < result) {
            result = dp[mask];
        }
    }

    return result;
}