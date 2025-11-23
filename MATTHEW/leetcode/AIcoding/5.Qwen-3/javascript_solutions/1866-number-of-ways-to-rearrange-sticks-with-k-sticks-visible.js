function rearrangeSticks(n, k) {
    const MOD = 10 ** 9 + 7;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        dp[i][0] = 0;
    }

    for (let i = 0; i <= n; i++) {
        dp[i][1] = 1;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 2; j <= k; j++) {
            dp[i][j] = (dp[i - 1][j - 1] + (i - 1) * dp[i - 1][j]) % MOD;
        }
    }

    return dp[n][k];
}