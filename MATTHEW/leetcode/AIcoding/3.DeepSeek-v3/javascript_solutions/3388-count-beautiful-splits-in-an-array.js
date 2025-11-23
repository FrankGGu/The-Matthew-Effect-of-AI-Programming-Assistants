var beautifulPartitions = function(s, k, minLength) {
    const n = s.length;
    const MOD = 1e9 + 7;
    const primes = new Set(['2', '3', '5', '7']);

    if (!primes.has(s[0]) || primes.has(s[n - 1])) {
        return 0;
    }

    const dp = new Array(k + 1).fill().map(() => new Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let parts = 1; parts <= k; parts++) {
        for (let i = 1; i <= n; i++) {
            if (!primes.has(s[i - 1])) {
                continue;
            }
            for (let j = i - minLength; j >= 0; j--) {
                if (primes.has(s[j])) {
                    continue;
                }
                dp[parts][i] = (dp[parts][i] + dp[parts - 1][j]) % MOD;
            }
        }
    }

    return dp[k][n];
};