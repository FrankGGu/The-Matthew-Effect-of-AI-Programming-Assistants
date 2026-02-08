var waysToEarnPoints = function(points, a, b, c) {
    const mod = 1e9 + 7;
    const dp = Array(points + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= points; i++) {
        if (i - a >= 0) dp[i] = (dp[i] + dp[i - a]) % mod;
        if (i - b >= 0) dp[i] = (dp[i] + dp[i - b]) % mod;
        if (i - c >= 0) dp[i] = (dp[i] + dp[i - c]) % mod;
    }

    return dp[points];
};