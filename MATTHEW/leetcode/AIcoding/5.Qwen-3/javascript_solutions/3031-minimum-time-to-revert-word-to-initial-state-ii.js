function minTimeToRevert(s, cost) {
    const n = s.length;
    const dp = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        dp[i] = dp[i - 1] + cost[i][0];
        for (let j = 1; j <= i; j++) {
            if (s[i - j] === s[i]) {
                dp[i] = Math.min(dp[i], dp[i - j] + cost[i][j]);
            }
        }
    }

    return dp[n - 1];
}