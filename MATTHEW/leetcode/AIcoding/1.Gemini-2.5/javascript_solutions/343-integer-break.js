var integerBreak = function(n) {
    if (n <= 3) {
        return n - 1;
    }

    const dp = new Array(n + 1).fill(0);
    dp[1] = 1;
    dp[2] = 2;
    dp[3] = 3;

    for (let i = 4; i <= n; i++) {
        for (let j = 1; j <= i / 2; j++) {
            dp[i] = Math.max(dp[i], dp[j] * dp[i - j]);
        }
    }

    return dp[n];
};