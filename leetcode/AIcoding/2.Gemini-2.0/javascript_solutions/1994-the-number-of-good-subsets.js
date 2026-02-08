var numberOfGoodSubsets = function(nums) {
    const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
    const MOD = 10**9 + 7;
    const mask = [0,0,1,2,0,3,0,4,0,0,0,5,0,6,0,0,0,7,0,8,0,0,0,9,0,0,0,10,0,11];
    const count = new Array(31).fill(0);
    for (const num of nums) {
        count[num]++;
    }

    const dp = new Array(1 << primes.length).fill(0);
    dp[0] = 1;

    for (let i = 2; i <= 30; i++) {
        if (count[i] === 0) continue;
        let msk = 0;
        let x = i;
        let ok = true;
        for (let j = 0; j < primes.length; j++) {
            if (x % primes[j] === 0) {
                if (x % (primes[j] * primes[j]) === 0) {
                    ok = false;
                    break;
                }
                msk |= (1 << j);
            }
        }
        if (!ok) continue;

        for (let j = (1 << primes.length) - 1; j >= 0; j--) {
            if ((j & msk) === 0) {
                dp[j | msk] = (dp[j | msk] + (dp[j] * count[i]) % MOD) % MOD;
            }
        }
    }

    let ans = 0;
    for (let i = 1; i < (1 << primes.length); i++) {
        ans = (ans + dp[i]) % MOD;
    }

    let ones = count[1];
    let pow2 = 1;
    for (let i = 0; i < ones; i++) {
        pow2 = (pow2 * 2) % MOD;
    }

    return (ans * pow2) % MOD;
};