var minSessions = function(tasks, sessionTime) {
    const n = tasks.length;
    let dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 1; mask < (1 << n); mask++) {
        let currentTime = 0;
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                currentTime += tasks[i];
            }
        }
        if (currentTime <= sessionTime) {
            dp[mask] = 1;
        }
    }

    for (let mask = 1; mask < (1 << n); mask++) {
        if (dp[mask] === 1) continue;
        for (let subset = mask; subset > 0; subset = (subset - 1) & mask) {
            dp[mask] = Math.min(dp[mask], dp[subset] + dp[mask ^ subset]);
        }
    }

    return dp[(1 << n) - 1];
};