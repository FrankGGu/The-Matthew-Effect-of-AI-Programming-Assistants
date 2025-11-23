var countSquareFreeSubsets = function(nums) {
    const MOD = 1e9 + 7;
    const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
    const primeIdxMap = new Map();
    for (let i = 0; i < primes.length; i++) {
        primeIdxMap.set(primes[i], i);
    }

    // dp[mask] stores the number of square-free subsequences whose product has prime factors represented by 'mask'.
    const dp = new Array(1 << primes.length).fill(0);
    dp[0] = 1; // Represents the empty subsequence, product is 1 (square-free, no prime factors)

    let countOnes = 0;

    // Iterate through each number in the input array
    for (const num of nums) {
        if (num === 1) {
            countOnes++;
            continue;
        }

        let tempNum = num;
        let currentMask = 0;
        let isSquareFree = true;

        // Check if num is square-free and calculate its prime factor mask
        for (const p of primes) {
            if (tempNum % p === 0) {
                currentMask |= (1 << primeIdxMap.get(p));
                tempNum /= p;
                if (tempNum % p === 0) { // Not square-free (divisible by p^2)
                    isSquareFree = false;
                    break;
                }
            }
        }

        if (isSquareFree) {
            // Iterate downwards to ensure that when processing 'num',
            // dp[mask | currentMask] is updated using dp[mask] from the previous iteration's state.
            // This correctly counts subsequences, allowing for multiple occurrences of the same number
            // to form distinct subsequences (e.g., if nums = [2, 2], {nums[0]} and {nums[1]} are distinct).
            for (let mask = (1 << primes.length) - 1; mask >= 0; mask--) {
                if (dp[mask] > 0) {
                    // Check if 'num' shares any prime factors with the current 'mask'
                    // If it does, adding 'num' would make the product not square-free.
                    if ((mask & currentMask) === 0) {
                        dp[mask | currentMask] = (dp[mask | currentMask] + dp[mask]) % MOD;
                    }
                }
            }
        }
    }

    let totalSquareFreeSubsequences = 0;
    for (const val of dp) {
        totalSquareFreeSubsequences = (totalSquareFreeSubsequences + val) % MOD;
    }

    // Account for the '1's. Each '1' can either be included or not.
    // If there are 'k' ones, there are 2^k ways to choose subsequences of ones.
    // Each of these 2^k choices can be combined with any square-free subsequence formed by other numbers.
    for (let i = 0; i < countOnes; i++) {
        totalSquareFreeSubsequences = (totalSquareFreeSubsequences * 2) % MOD;
    }

    // The problem asks for the number of square-free subsets, which typically means non-empty.
    // The 'totalSquareFreeSubsequences' currently includes the empty set.
    // Subtract 1 for the empty set. Add MOD before subtracting 1 to handle potential negative results from modulo.
    return (totalSquareFreeSubsequences - 1 + MOD) % MOD;
};