var kthSmallestAmount = function(denominations, k) {
    const n = denominations.length;

    function gcdBigInt(a, b) {
        while (b > 0n) {
            [a, b] = [b, a % b];
        }
        return a;
    }

    // Function to calculate LCM for a subset of denominations.
    // It returns the LCM (BigInt), or a value greater than target_limit (BigInt) if the LCM exceeds it.
    function getLcmForSubset(subset_mask, denominations, target_limit_bigint) {
        let current_lcm = 1n; // Start with BigInt 1
        for (let i = 0; i < n; i++) {
            if ((subset_mask >> i) & 1) { // If denominations[i] is in the subset
                const d = BigInt(denominations[i]); // Convert denomination to BigInt

                // If current_lcm is already too large, it will remain so or grow larger.
                if (current_lcm > target_limit_bigint) {
                    return target_limit_bigint + 1n;
                }

                const common = gcdBigInt(current_lcm, d);
                const factor = current_lcm / common; // This is a BigInt

                // Check if factor * d would exceed target_limit_bigint before multiplication
                // If factor > target_limit_bigint / d, then factor * d > target_limit_bigint
                if (factor > target_limit_bigint / d) {
                    current_lcm = target_limit_bigint + 1n; // Indicate overflow/too large
                } else {
                    current_lcm = factor * d;
                }
            }
        }
        return current_lcm;
    }

    // `countAmounts(target_bigint)` function: counts how many unique amounts <= target_bigint can be formed
    function countAmounts(target_bigint) {
        let total_count = 0n; // Use BigInt for total_count as it can be very large

        // Iterate through all non-empty subsets (masks from 1 to 2^n - 1)
        for (let i = 1; i < (1 << n); i++) {
            const lcm_val = getLcmForSubset(i, denominations, target_bigint);

            if (lcm_val > target_bigint) {
                // This subset's LCM is too large, it contributes 0 to the count for target_bigint.
                continue;
            }

            // Count how many denominations are in this subset (popcount)
            let set_bits = 0;
            for (let j = 0; j < n; j++) {
                if ((i >> j) & 1) {
                    set_bits++;
                }
            }

            // Apply inclusion-exclusion principle
            if (set_bits % 2 === 1) { // Odd number of elements in subset, add
                total_count += target_bigint / lcm_val;
            } else { // Even number of elements in subset, subtract
                total_count -= target_bigint / lcm_val;
            }
        }
        return total_count;
    }

    // Binary search for the answer
    // The range for the answer:
    // Minimum possible amount is 1.
    // Maximum possible amount can be estimated as k * max(denominations).
    // Max denomination is 10^5, max k is 10^9. So max answer can be around 10^14.
    // A safe upper bound for binary search: 2 * 10^14.
    let low = 1n;
    let high = 200000000000000n; // 2 * 10^14 as a BigInt
    let ans = high; // Initialize with a value that will be updated

    while (low <= high) {
        const mid = low + (high - low) / 2n; // mid is BigInt
        const count = countAmounts(mid); // count is BigInt

        if (count >= BigInt(k)) { // If we have at least k amounts, mid could be the answer or smaller
            ans = mid;
            high = mid - 1n;
        } else { // Not enough amounts, mid is too small
            low = mid + 1n;
        }
    }

    return Number(ans); // Convert BigInt result back to Number
};