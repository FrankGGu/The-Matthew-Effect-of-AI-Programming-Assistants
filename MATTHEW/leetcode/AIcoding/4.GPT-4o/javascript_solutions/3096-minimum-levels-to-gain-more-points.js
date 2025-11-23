function minLevels(points) {
    const n = points.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = i; j > 0; j--) {
            dp[j] = Math.min(dp[j], dp[j - 1] + points[i - 1]);
        }
    }

    for (let i = 1; i <= n; i++) {
        if (dp[i] <= 0) return i;
    }

    return n;
}