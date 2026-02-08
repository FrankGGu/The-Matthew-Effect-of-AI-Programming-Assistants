function countHousePlacements(n) {
    const mod = 1e9 + 7;
    const dp = new Array(n + 1).fill(0);

    dp[0] = 1;
    dp[1] = 2;

    for (let i = 2; i <= n; i++) {
        dp[i] = (dp[i - 1] + dp[i - 2]) % mod;
    }

    return (dp[n] * dp[n]) % mod;
}