var triplesWithBitwiseANDEqualToZero = function(nums) {
    const maxVal = 1 << 16; // Maximum possible value for nums[i] is 2^16 - 1.
                            // We need an array up to this value.
    const dp = new Array(maxVal).fill(0);
    const n = nums.length;

    // Step 1: Populate dp array with counts of (nums[i] & nums[j])
    // dp[x] will store the number of pairs (i, j) such that (nums[i] & nums[j]) === x.
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            dp[nums[i] & nums[j]]++;
        }
    }

    // Step 2: Transform dp using Sum Over Subsets (SOS) DP.
    // After this transformation, dp[mask] will store the sum of original_dp[submask]
    // for all submask that are subsets of 'mask'.
    for (let bit = 0; bit < 16; bit++) { // Iterate through each bit position (0 to 15)
        for (let mask = 0; mask < maxVal; mask++) { // Iterate through all possible masks
            if ((mask & (1 << bit)) !== 0) { // If the 'bit'-th bit is set in 'mask'
                // Add the count from the submask where this bit is not set.
                // This accumulates counts from all submasks.
                dp[mask] += dp[mask ^ (1 << bit)];
            }
        }
    }

    // Step 3: Calculate the total count of triples (i, j, k)
    let totalCount = 0;
    for (let k = 0; k < n; k++) {
        // We need (nums[i] & nums[j] & nums[k]) === 0.
        // Let x = (nums[i] & nums[j]). We need (x & nums[k]) === 0.
        // This condition implies that 'x' must not have any bits set that are also set in 'nums[k]'.
        // In other words, 'x' must be a submask of the bitwise complement of 'nums[k]'
        // (restricted to the 16-bit range).
        const complementMask = (~nums[k]) & (maxVal - 1);

        // Now, dp[complementMask] contains the sum of original_dp[x] for all x that are
        // submasks of complementMask. These are exactly the 'x' values for which (x & nums[k]) === 0.
        totalCount += dp[complementMask];
    }

    return totalCount;
};