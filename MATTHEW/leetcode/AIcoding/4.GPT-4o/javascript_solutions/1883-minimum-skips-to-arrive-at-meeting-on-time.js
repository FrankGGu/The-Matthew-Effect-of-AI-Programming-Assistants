var minSkips = function(dist, speed, hoursBefore) {
    const n = dist.length;
    const dp = Array.from({ length: n + 1 }, () => Array(n + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= i; j++) {
            const timeSpent = dp[i - 1][j] + dist[i - 1] / speed;
            if (j < i) {
                dp[i][j + 1] = Math.min(dp[i][j + 1], Math.ceil(timeSpent));
            }
            dp[i][j] = Math.min(dp[i][j], Math.ceil(timeSpent));
        }
    }

    for (let skips = 0; skips <= n; skips++) {
        if (dp[n][skips] <= hoursBefore) {
            return skips;
        }
    }
    return -1;
};