var numberOfWays = function(n, x) {
    const MOD = 1000000007;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; Math.pow(i, x) <= n; i++) {
        const power = Math.pow(i, x);
        for (let j = n; j >= power; j--) {
            dp[j] = (dp[j] + dp[j - power]) % MOD;
        }
    }

    return dp[n];
};