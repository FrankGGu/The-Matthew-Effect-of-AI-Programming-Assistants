function minSessions(tasks, sessionTime) {
    const n = tasks.length;
    const dp = Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] === Infinity) continue;
        for (let i = 0; i < n; i++) {
            if (!(mask & (1 << i))) {
                let newMask = mask | (1 << i);
                let remaining = sessionTime - tasks[i];
                for (let j = 0; j < n; j++) {
                    if (mask & (1 << j)) {
                        remaining -= tasks[j];
                    }
                }
                if (remaining < 0) {
                    dp[newMask] = Math.min(dp[newMask], dp[mask] + 1);
                } else {
                    dp[newMask] = Math.min(dp[newMask], dp[mask]);
                }
            }
        }
    }

    return dp[(1 << n) - 1];
}