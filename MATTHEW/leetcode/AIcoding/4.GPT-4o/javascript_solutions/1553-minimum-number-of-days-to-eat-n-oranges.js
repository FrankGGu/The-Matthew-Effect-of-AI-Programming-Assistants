var minDays = function(n) {
    let dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = i;
        if (i >= 2) dp[i] = Math.min(dp[i], 1 + dp[Math.floor(i / 2)]);
        if (i >= 3) dp[i] = Math.min(dp[i], 1 + dp[Math.floor(i / 3)]);
    }
    return dp[n];
};