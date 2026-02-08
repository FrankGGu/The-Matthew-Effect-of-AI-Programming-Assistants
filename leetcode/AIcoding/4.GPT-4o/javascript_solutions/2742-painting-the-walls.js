function paintWalls(wall) {
    const n = wall.length;
    if (n === 0) return 0;

    const dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + wall[i - 1];
        for (let j = 1; j < i; j++) {
            dp[i] = Math.min(dp[i], dp[j] + Math.max(0, wall[i - 1] - wall[j - 1]));
        }
    }
    return dp[n];
}