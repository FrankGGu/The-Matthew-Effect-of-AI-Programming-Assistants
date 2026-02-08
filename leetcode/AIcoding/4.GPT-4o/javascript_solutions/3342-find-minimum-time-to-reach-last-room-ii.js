function findMinimumTime(rooms) {
    const n = rooms.length;
    const dp = Array(n).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        const [time, keys] = rooms[i];
        for (const key of keys) {
            dp[key] = Math.min(dp[key], dp[i] + time);
        }
    }

    return dp[n - 1] === Infinity ? -1 : dp[n - 1];
}