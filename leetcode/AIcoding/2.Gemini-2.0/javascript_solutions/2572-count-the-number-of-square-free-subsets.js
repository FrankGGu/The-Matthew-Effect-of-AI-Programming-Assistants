var countSquareFreeSubsets = function(nums) {
    const MOD = 10**9 + 7;
    const PRIMES = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
    const MASK = [
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
        10, 11, 12, 13, 14, 0, 15, 16, 17, 18,
        0, 19, 20, 0, 21, 0, 22, 23, 0, 24,
        0
    ];

    const dp = new Array(1 << PRIMES.length).fill(0);
    dp[0] = 1;

    for (const num of nums) {
        if (num === 1) {
            for (let i = 0; i < (1 << PRIMES.length); i++) {
                dp[i] = (dp[i] * 2) % MOD;
            }
            continue;
        }

        let mask = 0;
        let squareFree = true;
        for (let i = 0; i < PRIMES.length; i++) {
            if (num % PRIMES[i] === 0) {
                if (num % (PRIMES[i] * PRIMES[i]) === 0) {
                    squareFree = false;
                    break;
                }
                mask |= (1 << i);
            }
        }

        if (!squareFree) continue;

        for (let i = (1 << PRIMES.length) - 1; i >= 0; i--) {
            if ((i & mask) === 0) {
                dp[i | mask] = (dp[i | mask] + dp[i]) % MOD;
            }
        }
    }

    let ans = 0;
    for (let i = 1; i < (1 << PRIMES.length); i++) {
        ans = (ans + dp[i]) % MOD;
    }

    return ans;
};