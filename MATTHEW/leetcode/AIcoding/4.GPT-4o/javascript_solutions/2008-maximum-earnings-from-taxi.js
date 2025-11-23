function maxTaxiEarnings(n, rides) {
    const dp = new Array(n + 1).fill(0);
    for (const [start, end, tip] of rides) {
        dp[end] = Math.max(dp[end], dp[start] + (end - start + tip));
    }
    for (let i = 1; i <= n; i++) {
        dp[i] = Math.max(dp[i], dp[i - 1]);
    }
    return dp[n];
}