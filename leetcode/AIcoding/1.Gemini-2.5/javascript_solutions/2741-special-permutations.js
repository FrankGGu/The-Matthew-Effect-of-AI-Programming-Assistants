var specialPermutations = function(nums) {
    const n = nums.length;
    const MOD = 10 ** 9 + 7;

    // dp[mask][last_idx] stores the number of special permutations
    // using elements represented by 'mask', ending with nums[last_idx].
    // mask: a bitmask where the i-th bit is set if nums[i] is used.
    // last_idx: the index of the last element in the permutation.
    const dp = Array(1 << n).fill(0).map(() => Array(n).fill(0));

    // Base cases: A single element permutation is always special.
    // For each element nums[i], a permutation of just [nums[i]] has count 1.
    for (let i = 0; i < n; i++) {
        dp[1 << i][i] = 1;
    }

    // Iterate through all possible masks (subsets of nums)
    // from 1 up to (1 << n) - 1 (all elements included).
    for (let mask = 1; mask < (1 << n); mask++) {
        // Iterate through all possible last elements for the current mask.
        for (let j = 0; j < n; j++) {
            // If nums[j] is not part of the current mask, skip.
            if (!((mask >> j) & 1)) {
                continue;
            }

            // If the current mask represents a single element, it's a base case
            // already initialized, so we skip further calculation for this mask/j combination.
            if (mask === (1 << j)) {
                continue;
            }

            // Iterate through all possible previous elements 'i' in the permutation.
            // 'i' must be part of the mask, and 'i' must not be 'j'.
            for (let i = 0; i < n; i++) {
                if (i === j) {
                    continue;
                }
                // If nums[i] was part of the previous mask (mask excluding nums[j])
                if (((mask >> i) & 1)) {
                    // Check the special permutation condition:
                    // nums[j] is divisible by nums[i] OR nums[i] is divisible by nums[j]
                    if (nums[j] % nums[i] === 0 || nums[i] % nums[j] === 0) {
                        // Add the count of permutations ending with nums[i]
                        // from the state where nums[j] was not yet included.
                        dp[mask][j] = (dp[mask][j] + dp[mask ^ (1 << j)][i]) % MOD;
                    }
                }
            }
        }
    }

    // The total number of special permutations is the sum of all
    // dp states where all elements are used (mask = (1 << n) - 1)
    // and ending with any possible element.
    let totalSpecialPermutations = 0;
    const fullMask = (1 << n) - 1;
    for (let i = 0; i < n; i++) {
        totalSpecialPermutations = (totalSpecialPermutations + dp[fullMask][i]) % MOD;
    }

    return totalSpecialPermutations;
};