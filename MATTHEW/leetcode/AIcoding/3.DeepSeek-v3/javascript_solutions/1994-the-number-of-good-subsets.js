var numberOfGoodSubsets = function(nums) {
    const MOD = 1e9 + 7;
    const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
    const count = new Array(31).fill(0);
    for (const num of nums) {
        count[num]++;
    }

    const dp = new Array(1 << primes.length).fill(0);
    dp[0] = 1;

    for (let num = 2; num <= 30; num++) {
        if (count[num] === 0) continue;
        let mask = 0;
        let tmp = num;
        let valid = true;
        for (let i = 0; i < primes.length; i++) {
            const p = primes[i];
            if (tmp % (p * p) === 0) {
                valid = false;
                break;
            }
            if (tmp % p === 0) {
                mask |= (1 << i);
            }
        }
        if (!valid) continue;
        for (let state = (1 << primes.length) - 1; state >= 0; state--) {
            if ((state & mask) === 0) {
                dp[state | mask] = (dp[state | mask] + dp[state] * count[num]) % MOD;
            }
        }
    }

    let res = 0;
    for (let state = 1; state < (1 << primes.length); state++) {
        res = (res + dp[state]) % MOD;
    }

    let ones = 1;
    for (let i = 0; i < count[1]; i++) {
        ones = (ones * 2) % MOD;
    }

    return res * ones % MOD;
};