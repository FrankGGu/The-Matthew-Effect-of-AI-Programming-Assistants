var squareFreeSubsets = function(nums) {
    const MOD = 10**9 + 7;
    const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31];
    const primeSet = new Set(primes);

    const dp = new Map();
    dp.set(0, 1);

    for (const num of nums) {
        let mask = 0;
        let n = num;
        for (const p of primes) {
            if (n % p === 0) {
                n /= p;
                if (n % p === 0) {
                    mask = -1;
                    break;
                }
                mask |= 1 << primes.indexOf(p);
            }
        }
        if (mask === -1) continue;

        const temp = new Map(dp);
        for (const [key, value] of dp) {
            if ((key & mask) === 0) {
                temp.set(key | mask, (temp.get(key | mask) || 0) + value);
            }
        }
        dp.clear();
        for (const [k, v] of temp) {
            dp.set(k, v);
        }
    }

    let result = 0;
    for (const [_, count] of dp) {
        result = (result + count) % MOD;
    }
    return result;
};