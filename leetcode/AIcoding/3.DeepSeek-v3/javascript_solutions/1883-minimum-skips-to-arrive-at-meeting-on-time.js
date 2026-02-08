var minSkips = function(dist, speed, hoursBefore) {
    const n = dist.length;
    const eps = 1e-9;
    const dp = Array.from({ length: n + 1 }, () => new Array(n + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; ++i) {
        const d = dist[i - 1];
        for (let j = 0; j <= i; ++j) {
            if (j > 0) {
                dp[i][j] = Math.min(dp[i][j], Math.floor(dp[i - 1][j - 1] + d / speed + eps);
            }
            if (j <= i - 1) {
                dp[i][j] = Math.min(dp[i][j], Math.ceil(dp[i - 1][j] + d / speed - eps));
            }
        }
    }

    for (let j = 0; j <= n; ++j) {
        if (dp[n][j] <= hoursBefore) {
            return j;
        }
    }

    return -1;
};