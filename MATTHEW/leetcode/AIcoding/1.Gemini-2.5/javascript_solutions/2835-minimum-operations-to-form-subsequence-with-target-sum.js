var minOperations = function(nums, target) {
    let totalSum = 0n; // Use BigInt for totalSum as it can exceed Number.MAX_SAFE_INTEGER
    const counts = new Map(); // Stores counts of each power of 2 from `nums`

    for (const num of nums) {
        counts.set(num, (counts.get(num) || 0) + 1);
        totalSum += BigInt(num);
    }

    if (totalSum < BigInt(target)) {
        return -1;
    }

    let operations = 0;
    let current_carry_sum = 0n; // Sum of powers of 2 (2^0 to 2^(i-1)) that are available from `nums` or splits. Using BigInt.

    // Iterate through bits from least significant to most significant.
    // Max target is 10^9, which is less than 2^30. Max num is 10^9.
    // totalSum can be up to 10^5 * 10^9 = 10^14, which is less than 2^47.
    // So iterating up to bit 60 (2^60) is a safe upper bound to cover all possible values.
    for (let i = 0; i < 61; ++i) { 
        const p = 1n << BigInt(i); // Current power of 2. Using BigInt.
        const p_num = Number(p); // For map lookup, convert BigInt p to Number

        // Add available 'p's from initial nums to current_carry_sum.
        current_carry_sum += BigInt(counts.get(p_num) || 0) * p;

        // Check if the i-th bit of target is set
        if (((BigInt(target) >> BigInt(i)) & 1n) === 1n) { // If target needs this bit
            if (current_carry_sum >= p) {
                // If we have enough sum from smaller or current powers, use one 'p'.
                current_carry_sum -= p;
            } else {
                // We need 'p' but don't have enough. Must get it from a larger power.
                // Find the smallest power of 2 (2^k) that we have (from initial nums) and is larger than 'p'.
                let foundLargerPower = -1;
                for (let k = i + 1; k < 61; ++k) {
                    const pk = 1n << BigInt(k);
                    if (counts.get(Number(pk)) > 0) {
                        foundLargerPower = Number(pk);
                        break;
                    }
                }

                if (foundLargerPower !== -1) {
                    // Use one instance of 'foundLargerPower' by splitting it.
                    counts.set(foundLargerPower, counts.get(foundLargerPower) - 1);

                    // The number of operations to get one 'p' from 'foundLargerPower' is log2(foundLargerPower) - log2(p).
                    // This is equivalent to `k - i`.
                    operations += (Math.log2(foundLargerPower) - i);

                    // The 'p' is used for target. The remaining pieces from splitting `foundLargerPower`
                    // contribute to `current_carry_sum`.
                    // Example: if foundLargerPower = 16, p = 4. One 4 is used. Remaining sum is 16 - 4 = 12.
                    current_carry_sum += BigInt(foundLargerPower) - p;
                } else {
                    // This case should not be reached if totalSum >= target.
                    // If totalSum is sufficient, we should always be able to find a way to form the target.
                    // This implies that if we are here, totalSum must have been less than target,
                    // or there's a flaw in the greedy strategy or problem interpretation.
                    // Given the problem constraints and typical LeetCode patterns,
                    // the initial `totalSum < target` check handles impossibility.
                    // This branch should ideally not be executed.
                }
            }
        }
        // At the end of each iteration, `current_carry_sum` contains the total sum of `2^i`s
        // that are not used for `target`'s current bit. This sum is carried over for higher bits.
    }

    return operations;
};