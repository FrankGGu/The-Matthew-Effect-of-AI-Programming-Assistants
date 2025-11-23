const MOD = 10 ** 9 + 7;
const MAX_NUM = 30000;
const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]; // Primes up to 29
const numPrimes = primes.length;

const prime_masks = new Array(MAX_NUM + 1).fill(0);

for (let i = 2; i <= MAX_NUM; i++) {
    let temp_mask = 0;
    let num = i;
    let is_square_free = true;

    for (let j = 0; j < numPrimes; j++) {
        const p = primes[j];
        if (num % p === 0) {
            temp_mask |= (1 << j);
            num /= p;
            if (num % p === 0) { // Not square-free (divisible by p^2)
                is_square_free = false;
                break;
            }
        }
    }

    if (!is_square_free || num > 1) { 
        // If not square-free OR has a prime factor > 29 (num > 1 after dividing by all primes <= 29)
        prime_masks[i] = -1;
    } else {
        prime_masks[i] = temp_mask;
    }
}

function power(base, exp, mod) {
    let res = 1;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 === 1) res = (res * base) % mod;
        base = (base * base) % mod;
        exp = Math.floor(exp / 2);
    }
    return res;
}

function numberOfGoodSubsets(nums) {
    const counts = new Array(MAX_NUM + 1).fill(0);
    for (const num of nums) {
        counts[num]++;
    }

    const dp = new Array(1 << numPrimes).fill(0);
    dp[0] = 1; // Represents the empty set, which has a product of 1 (mask 0)

    for (let i = 2; i <= MAX_NUM; i++) {
        if (prime_masks[i] === -1 || counts[i] === 0) {
            continue;
        }

        const current_mask = prime_masks[i];
        const num_occurrences = counts[i];

        // Iterate masks downwards to ensure that each number 'i' is considered
        // to extend previously formed subsets, not to form new subsets using 'i' multiple times
        // within the same iteration step.
        for (let mask = (1 << numPrimes) - 1; mask >= 0; mask--) {
            if ((mask & current_mask) === 0) { // If prime factors of 'i' are disjoint from 'mask'
                dp[mask | current_mask] = (dp[mask | current_mask] + dp[mask] * num_occurrences) % MOD;
            }
        }
    }

    let total_good_subsets = 0;
    for (let mask = 1; mask < (1 << numPrimes); mask++) { // Sum up all non-empty good subsets
        total_good_subsets = (total_good_subsets + dp[mask]) % MOD;
    }

    // Account for the number '1's. Each '1' can be optionally included in any good subset.
    // If there are k ones, there are 2^k ways to include them (including not including any).
    // This multiplies the number of good subsets by 2^k.
    const power_of_two_for_ones = power(2, counts[1], MOD);

    return (total_good_subsets * power_of_two_for_ones) % MOD;
}