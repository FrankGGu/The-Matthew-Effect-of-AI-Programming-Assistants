var minimumTime = function(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + 1;
        if (s[i - 1] === '1') {
            dp[i] = Math.min(dp[i], dp[Math.max(0,i - 2)] + 2);
        }
    }

    return dp[n];
};