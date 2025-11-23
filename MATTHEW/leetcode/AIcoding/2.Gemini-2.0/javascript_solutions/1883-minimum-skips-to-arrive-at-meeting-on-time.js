var minSkips = function(dist, speed, hoursBefore) {
    const n = dist.length;
    const dp = Array(n + 1).fill(null).map(() => Array(n + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= n; j++) {
            const time = dist[i - 1] / speed;

            // No skip
            if (j <= i - 1) {
                dp[i][j] = Math.ceil(dp[i - 1][j] + time);
            }

            // Skip
            if (j > 0) {
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - 1] + time);
            }
        }
    }

    for (let j = 0; j <= n; j++) {
        if (dp[n][j] <= hoursBefore) {
            return j;
        }
    }

    return -1;
};