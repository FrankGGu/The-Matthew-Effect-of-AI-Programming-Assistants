var beautifulPartitions = function(s, k, minLength) {
    const MOD = 1e9 + 7;
    const n = s.length;
    const primes = new Set(['2', '3', '5', '7']);

    if (!primes.has(s[0]) || primes.has(s[n - 1])) {
        return 0;
    }

    const dp = new Array(k + 1).fill().map(() => new Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let parts = 1; parts <= k; parts++) {
        let sum = 0;
        for (let i = 1; i <= n; i++) {
            if (i >= minLength) {
                const prev = i - minLength;
                if (prev >= 0 && !primes.has(s[prev])) {
                    sum = (sum + dp[parts - 1][prev]) % MOD;
                }
            }
            if (!primes.has(s[i - 1])) {
                dp[parts][i] = sum;
            }
        }
    }

    return dp[k][n];
};