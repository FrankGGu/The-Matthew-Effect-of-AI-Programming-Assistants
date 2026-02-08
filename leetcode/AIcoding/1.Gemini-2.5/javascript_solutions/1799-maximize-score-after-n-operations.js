var maxScore = function(nums) {
    const m = nums.length; // Total number of elements
    const n = m / 2;       // Number of operations

    // Helper function for Greatest Common Divisor (GCD)
    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    // Precompute GCDs for all possible pairs to avoid redundant calculations
    // allGcd[i][j] stores gcd(nums[i], nums[j])
    const allGcd = Array(m).fill(0).map(() => Array(m).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = i + 1; j < m; j++) {
            allGcd[i][j] = gcd(nums[i], nums[j]);
        }
    }

    // dp[mask] stores the maximum score achievable when the numbers represented
    // by the set bits in 'mask' have been used.
    // The size of dp array is 2^m, where m is the number of elements.
    const dp = Array(1 << m).fill(0);

    // Iterate through all possible masks from 0 up to (1 << m) - 1
    // A mask represents the set of numbers that have already been chosen.
    for (let mask = 0; mask < (1 << m); mask++) {
        // Calculate the number of elements already chosen (set bits in mask)
        let popcount = 0;
        for (let i = 0; i < m; i++) {
            if ((mask >> i) & 1) {
                popcount++;
            }
        }

        // We can only proceed if an even number of elements have been chosen so far,
        // because each operation consumes exactly two elements.
        if (popcount % 2 !== 0) {
            continue;
        }

        // Determine the current operation number (1-indexed).
        // If popcount = 0 (no elements chosen), currentOperation = 1 (first operation).
        // If popcount = 2 (two elements chosen), currentOperation = 2 (second operation).
        // In general, if popcount = 2k, currentOperation = k + 1.
        const currentOperation = popcount / 2 + 1;

        // If we have already completed all 'n' operations, or if the next operation
        // would exceed 'n', there's no need to perform further operations from this mask.
        if (currentOperation > n) {
            continue;
        }

        // Find the first unused number (the first bit that is 0 in the mask)
        let i = 0;
        while (i < m && ((mask >> i) & 1)) {
            i++;
        }

        // At this point, 'i' is the index of the first unused number.
        // If 'i' reaches 'm', it means all numbers are used. This case is handled
        // by the `currentOperation > n` check, as there would be no more operations.

        // Now, find the second unused number 'j' (after 'i')
        for (let j = i + 1; j < m; j++) {
            // If nums[j] is not used (i.e., the j-th bit is 0 in mask)
            if (!((mask >> j) & 1)) {
                // Form the new mask by including nums[i] and nums[j]
                const nextMask = mask | (1 << i) | (1 << j);

                // Calculate the score for this operation
                const scoreToAdd = currentOperation * allGcd[i][j];

                // Update the maximum score for nextMask
                dp[nextMask] = Math.max(dp[nextMask], dp[mask] + scoreToAdd);
            }
        }
    }

    // The final answer is the maximum score achievable when all numbers are used.
    // This corresponds to the mask where all bits are set: (1 << m) - 1.
    return dp[(1 << m) - 1];
};