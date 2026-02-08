var minAbsoluteSumDiff = function(nums1, nums2) {
    const MOD = 10 ** 9 + 7;
    const n = nums1.length;

    // Helper function for binary search (bisect_left equivalent)
    const bisectLeft = (arr, target) => {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    };

    // Create a sorted copy of nums1 for efficient searching
    const sortedNums1 = [...nums1].sort((a, b) => a - b);

    let totalDiff = 0;
    let maxSaving = 0; // This will store the maximum possible reduction from totalDiff

    for (let i = 0; i < n; i++) {
        const currentDiff = Math.abs(nums1[i] - nums2[i]);
        totalDiff = (totalDiff + currentDiff) % MOD;

        const target = nums2[i];

        // Find the index 'idx' in sortedNums1 where an element is closest to 'target'
        // 'idx' will be the insertion point, meaning sortedNums1[idx] >= target
        let idx = bisectLeft(sortedNums1, target);

        let minPossibleDiff = Infinity;

        // Check the element at 'idx' (if it exists)
        if (idx < n) {
            minPossibleDiff = Math.min(minPossibleDiff, Math.abs(sortedNums1[idx] - target));
        }
        // Check the element at 'idx - 1' (if it exists)
        if (idx > 0) {
            minPossibleDiff = Math.min(minPossibleDiff, Math.abs(sortedNums1[idx - 1] - target));
        }

        // The saving for this specific 'i' if we replace nums1[i] with the closest element from sortedNums1
        // is currentDiff - minPossibleDiff. We want to maximize this saving across all 'i'.
        maxSaving = Math.max(maxSaving, currentDiff - minPossibleDiff);
    }

    // The final result is the initial total difference minus the maximum saving we can achieve.
    // We add MOD before taking modulo to ensure the result is non-negative.
    return (totalDiff - maxSaving + MOD) % MOD;
};