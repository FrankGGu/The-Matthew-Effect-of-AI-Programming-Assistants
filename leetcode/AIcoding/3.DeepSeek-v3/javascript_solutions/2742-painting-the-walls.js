var paintWalls = function(cost, time) {
    const n = cost.length;
    const dp = new Array(n + 1).fill(Number.MAX_SAFE_INTEGER);
    dp[0] = 0;

    for (let i = 0; i < n; ++i) {
        for (let j = n; j >= 0; --j) {
            const newJ = Math.min(n, j + time[i] + 1);
            dp[newJ] = Math.min(dp[newJ], dp[j] + cost[i]);
        }
    }

    return dp[n];
};