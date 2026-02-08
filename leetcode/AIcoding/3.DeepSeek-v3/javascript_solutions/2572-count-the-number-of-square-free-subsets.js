const squareFreeSubsets = function(nums) {
    const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
    const MOD = 1e9 + 7;
    const n = nums.length;
    const dp = new Array(1 << 10).fill(0);
    dp[0] = 1;

    for (const num of nums) {
        if (num % 4 === 0 || num % 9 === 0 || num % 25 === 0) continue;
        let mask = 0;
        for (let i = 0; i < primes.length; i++) {
            if (num % primes[i] === 0) mask |= (1 << i);
        }
        for (let state = (1 << 10) - 1; state >= 0; state--) {
            if ((state & mask) === 0) {
                dp[state | mask] = (dp[state | mask] + dp[state]) % MOD;
            }
        }
    }

    let res = 0;
    for (let i = 0; i < (1 << 10); i++) {
        res = (res + dp[i]) % MOD;
    }
    return (res - 1 + MOD) % MOD;
};