var beautifulPartitions = function(s, k, minLength) {
    const n = s.length;
    const primes = new Set([2, 3, 5, 7]);
    const isPrimeDigit = (digit) => primes.has(digit);

    if (!isPrimeDigit(parseInt(s[0]))) {
        return 0;
    }
    if (!isPrimeDigit(parseInt(s[n - 1]))) {
        return 0;
    }

    const dp = Array(n + 1).fill(0);
    dp[0] = 1;
    const MOD = 10**9 + 7;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= i; j++) {
            if (i - j < minLength -1) continue;
            if (isPrimeDigit(parseInt(s[i - 1])) && (j === 1 || isPrimeDigit(parseInt(s[j - 1 - 1])))) {
                dp[i] = (dp[i] + dp[j - 1]) % MOD;
            }
        }
    }

    return dp[n];
};