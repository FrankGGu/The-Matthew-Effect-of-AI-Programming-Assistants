function numberOfWays(s, k) {
    const MOD = 1000000007;
    const n = s.length;
    const dp = Array.from({ length: n }, () => Array(k + 1).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][0] = 1;
    }

    for (let i = 1; i < n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (s[i] === 'A') {
                dp[i][j] += dp[i - 1][j - 1];
            } else if (s[i] === 'B') {
                dp[i][j] += dp[i - 1][j - 1];
            }
            dp[i][j] %= MOD;
        }
    }

    return dp[n - 1][k];
}