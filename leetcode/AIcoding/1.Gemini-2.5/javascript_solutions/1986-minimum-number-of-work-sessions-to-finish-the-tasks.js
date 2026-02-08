var minSessions = function(tasks, sessionTime) {
    const n = tasks.length;
    const numMasks = 1 << n;

    const sums = new Array(numMasks).fill(0);
    for (let mask = 1; mask < numMasks; mask++) {
        let lowbitIdx = 0;
        while (!((mask >> lowbitIdx) & 1)) {
            lowbitIdx++;
        }
        sums[mask] = sums[mask ^ (1 << lowbitIdx)] + tasks[lowbitIdx];
    }

    const dp = new Array(numMasks).fill(Infinity);
    dp[0] = 0;

    for (let mask = 1; mask < numMasks; mask++) {
        let submask = mask;
        while (submask > 0) {
            if (sums[submask] <= sessionTime) {
                dp[mask] = Math.min(dp[mask], 1 + dp[mask ^ submask]);
            }
            submask = (submask - 1) & mask;
        }
    }

    return dp[numMasks - 1];
};