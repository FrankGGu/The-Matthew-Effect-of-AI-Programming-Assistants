function maxPoints(points) {
    const n = points.length;
    const dp = Array(n).fill(0);
    dp[0] = points[0];

    for (let i = 1; i < n; i++) {
        dp[i] = points[i];
        for (let j = 0; j < i; j++) {
            if (i - j <= 1) continue;
            dp[i] = Math.max(dp[i], dp[j] + points[i]);
        }
    }

    return Math.max(...dp);
}