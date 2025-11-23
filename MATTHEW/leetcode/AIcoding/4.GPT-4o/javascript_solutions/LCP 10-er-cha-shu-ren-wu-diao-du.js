var minimumTime = function(tasks) {
    const n = tasks.length;
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        let currentTime = 0;
        for (let j = 0; j < n; j++) {
            if (mask & (1 << j)) {
                currentTime += tasks[j][0];
            }
        }

        for (let j = 0; j < n; j++) {
            if (!(mask & (1 << j))) {
                const newMask = mask | (1 << j);
                dp[newMask] = Math.min(dp[newMask], Math.max(dp[mask], currentTime + tasks[j][1]));
            }
        }
    }

    return dp[(1 << n) - 1];
};