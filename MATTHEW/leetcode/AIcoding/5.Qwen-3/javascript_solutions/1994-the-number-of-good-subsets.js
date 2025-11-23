var numberOfGoodSubsets = function(nums) {
    const MOD = 1000000007;
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31];
    const primeCount = new Map();

    for (const p of primes) {
        primeCount.set(p, 0);
    }

    const dp = new Array(1 << primes.length).fill(0);
    dp[0] = 1;

    for (const [num, count] of freq) {
        if (num === 1) continue;
        let mask = 0;
        let x = num;
        for (let i = 0; i < primes.length; i++) {
            if (x % primes[i] === 0) {
                mask |= 1 << i;
                x /= primes[i];
            }
        }
        if (x !== 1) continue;

        for (let i = (1 << primes.length) - 1; i >= 0; i--) {
            if ((i & mask) === 0) {
                dp[i | mask] = (dp[i | mask] + dp[i] * count) % MOD;
            }
        }
    }

    let result = 0;
    for (let i = 1; i < (1 << primes.length); i++) {
        result = (result + dp[i]) % MOD;
    }

    return result;
};