function numberOfWays(num) {
    const MOD = 10 ** 9 + 7;
    const n = num.length;
    const dp = Array(n).fill(0);
    dp[0] = 1;

    for (let i = 1; i < n; i++) {
        if (num[i] !== '0') {
            dp[i] = dp[i - 1];
        }

        if (num[i - 1] !== '0' && parseInt(num.substring(i - 1, i + 1)) <= 26) {
            dp[i] += (i >= 2 ? dp[i - 2] : 1);
            dp[i] %= MOD;
        }
    }

    return dp[n - 1];
}