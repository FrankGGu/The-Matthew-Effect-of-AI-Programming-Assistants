var minimumIncompatibility = function(nums, k) {
    const n = nums.length;
    const subsetSize = n / k;

    // Precompute popcount for all masks
    // popcount[i] stores the number of set bits in integer i
    const popcount = new Array(1 << n).fill(0);
    for (let i = 1; i < (1 << n); i++) {
        popcount[i] = popcount[i >> 1] + (i & 1);
    }

    // Precompute incompatibilities for all valid subsets of size subsetSize
    // subsetIncompatibilities[mask] stores the incompatibility of the subset
    // represented by mask. If the subset is invalid (e.g., has duplicates
    // or incorrect size), it's Infinity.
    const subsetIncompatibilities = new Array(1 << n).fill(Infinity);
    for (let mask = 1; mask < (1 << n); mask++) {
        if (popcount[mask] !== subsetSize) {
            continue;
        }

        let minVal = Infinity;
        let maxVal = -Infinity;
        const seenValues = new Set();
        let isValid = true;

        for (let i = 0; i < n; i++) {
            if ((mask >> i) & 1) { // If nums[i] is in the current subset mask
                const val = nums[i];
                if (seenValues.has(val)) {
                    isValid = false;
                    break;
                }
                seenValues.add(val);
                minVal = Math.min(minVal, val);
                maxVal = Math.max(maxVal, val);
            }
        }

        if (isValid) {
            subsetIncompatibilities[mask] = maxVal - minVal;
        }
    }

    // dp[mask] stores the minimum total incompatibility for the elements
    // represented by 'mask', assuming these elements have been partitioned
    // into popcount(mask) / subsetSize valid subsets.
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0; // Base case: no elements, no incompatibility

    // Iterate through all possible masks from 1 to (1 << n) - 1
    for (let mask = 1; mask < (1 << n); mask++) {
        // Only consider masks that represent a collection of full subsets
        // and for which a solution for a submask has been found.
        if (popcount[mask] % subsetSize !== 0 || dp[mask] === Infinity) {
            continue;
        }

        // Find the least significant bit (first element) in the current mask.
        // This element must be part of the last subset formed to reach this state.
        let firstBitIdx = 0;
        while (!((mask >> firstBitIdx) & 1)) {
            firstBitIdx++;
        }
        const firstBitMask = (1 << firstBitIdx);

        // Iterate through all submasks `s_prime` of `mask ^ firstBitMask`
        // that have `subsetSize - 1` elements.
        // Then form `currentSubsetMask = s_prime | firstBitMask`.

        const remainingMaskForSub = mask ^ firstBitMask;

        // Handle the case where subsetSize - 1 is 0 (i.e., subsetSize is 1).
        // In this case, s_prime must be 0.
        if (subsetSize - 1 === 0) {
            const currentSubsetMask = firstBitMask; // The subset only contains firstBitIdx
            if (subsetIncompatibilities[currentSubsetMask] !== Infinity && dp[mask ^ currentSubsetMask] !== Infinity) {
                dp[mask] = Math.min(dp[mask], dp[mask ^ currentSubsetMask] + subsetIncompatibilities[currentSubsetMask]);
            }
        }

        // Iterate through s_prime > 0 (submasks of remainingMaskForSub with subsetSize - 1 bits)
        let s_prime = remainingMaskForSub;
        while (s_prime > 0) {
            if (popcount[s_prime] === subsetSize - 1) {
                const currentSubsetMask = s_prime | firstBitMask;

                // If the current subset is valid and the previous state (mask ^ currentSubsetMask) is reachable
                if (subsetIncompatibilities[currentSubsetMask] !== Infinity && dp[mask ^ currentSubsetMask] !== Infinity) {
                    dp[mask] = Math.min(dp[mask], dp[mask ^ currentSubsetMask] + subsetIncompatibilities[currentSubsetMask]);
                }
            }
            s_prime = (s_prime - 1) & remainingMaskForSub;
        }
    }

    // The final answer is the minimum incompatibility for all elements (mask (1 << n) - 1).
    // The problem guarantees a solution exists, so it won't be Infinity.
    return dp[(1 << n) - 1];
};