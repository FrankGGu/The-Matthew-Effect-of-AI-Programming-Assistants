var minSessions = function(tasks, sessionTime) {
    const n = tasks.length;
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        let total = 0;
        for (let j = 0; j < n; j++) {
            if (mask & (1 << j)) {
                total += tasks[j];
            }
        }

        for (let j = 0; j < n; j++) {
            if (!(mask & (1 << j))) {
                const nextMask = mask | (1 << j);
                const newTotal = total + tasks[j];
                if (newTotal <= sessionTime) {
                    dp[nextMask] = Math.min(dp[nextMask], dp[mask]);
                } else {
                    dp[nextMask] = Math.min(dp[nextMask], dp[mask] + 1);
                }
            }
        }
    }

    return dp[(1 << n) - 1];
};