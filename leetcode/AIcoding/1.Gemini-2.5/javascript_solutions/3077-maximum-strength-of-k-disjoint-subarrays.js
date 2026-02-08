var maximumStrength = function(nums, k) {
    const n = nums.length;

    // A sufficiently small BigInt value to represent negative infinity.
    // The maximum possible strength can be very large (up to 10^24),
    // so -10^25n is chosen as a safe lower bound.
    const NEG_INF = -10n ** 25n;

    // Helper function for BigInt maximum
    const BigIntMax = (a, b) => (a > b ? a : b);

    // dp_not_ending[j]: maximum strength using j subarrays, where the j-th subarray does NOT end at the current index.
    // dp_ending[j]: maximum strength using j subarrays, where the j-th subarray DOES end at the current index.
    let dp_not_ending = Array(k + 1).fill(NEG_INF);
    let dp_ending = Array(k + 1).fill(NEG_INF);

    // Base case: 0 subarrays have 0 strength.
    dp_not_ending[0] = 0n;

    for (let i = 0; i < n; i++) {
        const currentNum = BigInt(nums[i]);

        // Create new DP arrays for the current iteration (i)
        // This is crucial to use values from the previous iteration (i-1) when calculating for the current (i).
        let next_dp_not_ending = Array(k + 1).fill(NEG_INF);
        let next_dp_ending = Array(k + 1).fill(NEG_INF);

        // 0 subarrays still have 0 strength, not ending at current index.
        next_dp_not_ending[0] = 0n;

        for (let j = 1; j <= k; j++) {
            // Calculate the multiplier for the j-th subarray.
            // It's (k - j + 1) if j is odd, and -(k - j + 1) if j is even.
            const multiplier = BigInt((k - j + 1) * (j % 2 === 1 ? 1 : -1));

            // Calculate next_dp_ending[j]: max strength for j subarrays, ending at current index i.
            // Option 1: Extend the j-th subarray that ended at the previous index (i-1).
            let extend_val = NEG_INF;
            if (dp_ending[j] !== NEG_INF) {
                extend_val = dp_ending[j] + currentNum * multiplier;
            }

            // Option 2: Start a new j-th subarray at the current index (i).
            // This means j-1 subarrays must have been completed before the current index (i).
            // The maximum strength for j-1 subarrays ending before index i is BigIntMax(dp_not_ending[j-1], dp_ending[j-1]).
            let start_val_base = BigIntMax(dp_not_ending[j-1], dp_ending[j-1]);
            let start_val = NEG_INF;
            if (start_val_base !== NEG_INF) {
                start_val = start_val_base + currentNum * multiplier;
            }

            next_dp_ending[j] = BigIntMax(extend_val, start_val);

            // Calculate next_dp_not_ending[j]: max strength for j subarrays, not ending at current index i.
            // This means the j-th subarray ended before the current index (i).
            // So, we take the maximum strength for j subarrays from the previous step (i-1),
            // regardless of whether the j-th subarray ended at (i-1) or not.
            next_dp_not_ending[j] = BigIntMax(dp_not_ending[j], dp_ending[j]);
        }

        // Update dp arrays for the next iteration.
        dp_not_ending = next_dp_not_ending;
        dp_ending = next_dp_ending;
    }

    // The final answer is the maximum strength using exactly k subarrays,
    // considering all elements up to n-1. This can be either a solution
    // where the k-th subarray ends at n-1 (dp_ending[k]) or before n-1 (dp_not_ending[k]).
    return BigIntMax(dp_not_ending[k], dp_ending[k]);
};