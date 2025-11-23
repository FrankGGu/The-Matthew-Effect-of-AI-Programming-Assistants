var numberOfWays = function(n, x) {
    const MOD = 1e9 + 7;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let a = 1; ; a++) {
        const power = Math.pow(a, x);
        if (power > n) break;

        for (let i = n; i >= power; i--) {
            dp[i] = (dp[i] + dp[i - power]) % MOD;
        }
    }

    return dp[n];
};