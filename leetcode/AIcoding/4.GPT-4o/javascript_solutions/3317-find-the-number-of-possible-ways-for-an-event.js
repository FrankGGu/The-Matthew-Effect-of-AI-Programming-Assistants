function countWays(n, k) {
    let mod = 1e9 + 7;
    let dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= Math.min(i, k); j++) {
            dp[i] = (dp[i] + dp[i - j]) % mod;
        }
    }

    return dp[n];
}