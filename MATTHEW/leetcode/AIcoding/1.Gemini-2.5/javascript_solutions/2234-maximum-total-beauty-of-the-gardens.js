var maximumBeauty = function(flowers, newFlowers, full, partial) {
    const n = flowers.length;
    flowers.sort((a, b) => a - b);

    // Calculate prefix sums for efficient range sum queries
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + flowers[i];
    }

    // Helper function to find the count of elements in a sorted array `arr[0...endExclusive-1]`
    // that are strictly less than `target`. This is equivalent to `lower_bound` in C++
    // or `bisect_left` in Python, returning the first index `j` where `arr[j] >= target`.
    // All elements before `j` are `< target`.
    function getCountOfElementsLessThan(arr, target, endExclusive) {
        let low = 0;
        let high = endExclusive - 1;
        let ans = endExclusive; // Default: all elements are less than target or array is empty

        while (low <= high) {
            let midIdx = Math.floor((low + high) / 2);
            if (arr[midIdx] >= target) {
                ans = midIdx;
                high = midIdx - 1;
            } else {
                low = midIdx + 1;
            }
        }
        return ans;
    }

    let maxTotalBeauty = 0;

    // Iterate `i` from `n` down to `0`.
    // `i` represents the number of gardens that are NOT made full. These are `flowers[0]` to `flowers[i-1]`.
    // The remaining `n - i` gardens (`flowers[i]` to `flowers[n-1]`) are considered for `full` beauty.
    for (let i = n; i >= 0; i--) {
        const numFullGardens = n - i;
        let costForFullGardens = 0;

        if (numFullGardens > 0) {
            // Cost to make the `numFullGardens` largest gardens full.
            // Sum of (full - flowers[j]) for j from i to n-1
            // This is (numFullGardens * full) - sum(flowers[i]...flowers[n-1])
            costForFullGardens = numFullGardens * full - (prefixSum[n] - prefixSum[i]);
        }

        if (costForFullGardens > newFlowers) {
            // If we cannot even afford to make these `numFullGardens` full,
            // we cannot make more full gardens (as `i` decreases, `numFullGardens` increases).
            // So, we break the loop.
            break;
        }

        const remainingBudget = newFlowers - costForFullGardens;
        let currentMinBeautyForPartial = 0;

        if (i > 0) { // If there are gardens remaining to be considered for partial beauty
            // Binary search for the maximum possible `minBeauty` for `flowers[0]...flowers[i-1]`.
            // This `minBeauty` must be at least `partial` and at most `full - 1`.
            let low = partial;
            let high = full - 1;
            let ansForPartial = 0;

            // Only run binary search if a valid range exists (i.e., `partial < full`).
            // If `partial >= full`, no garden can be "partial" and contribute `partial` beauty,
            // because it would either already be full or cannot be made partial without being full.
            // In this case, `ansForPartial` remains 0, which is correct.
            if (low <= high) {
                while (low <= high) {
                    const mid = Math.floor((low + high) / 2);

                    // `idx` is the count of flowers in `flowers[0...i-1]` that are less than `mid`.
                    const idx = getCountOfElementsLessThan(flowers, mid, i);

                    // Cost to raise these `idx` flowers to `mid`:
                    // sum(mid - flowers[j]) for j from 0 to idx-1
                    const costToRaisePartial = idx * mid - prefixSum[idx];

                    if (costToRaisePartial <= remainingBudget) {
                        ansForPartial = mid;
                        low = mid + 1; // Try for a higher `minBeauty`
                    } else {
                        high = mid - 1; // Need a lower `minBeauty`
                    }
                }
            }
            currentMinBeautyForPartial = ansForPartial;
        }

        // Calculate the total beauty for the current configuration
        // (numFullGardens * full_beauty) + (numPartialGardens * min_beauty_of_partial_gardens)
        const totalBeauty = (numFullGardens * full) + (i > 0 ? currentMinBeautyForPartial * partial : 0);
        maxTotalBeauty = Math.max(maxTotalBeauty, totalBeauty);
    }

    return maxTotalBeauty;
};