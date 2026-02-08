var minOperations = function(nums1, nums2) {
    const n = nums1.length;

    function calculateSwaps(target1, target2) {
        let swaps = 0;
        for (let i = 0; i < n - 1; i++) {
            const currentNum1 = nums1[i];
            const currentNum2 = nums2[i];

            if (currentNum1 <= target1 && currentNum2 <= target2) {
                // Both elements already satisfy the conditions, no swap needed for this index
                continue;
            } else if (currentNum1 > target1 && currentNum2 > target2) {
                // Both elements are too large for their respective targets, impossible
                return Infinity;
            } else {
                // One element is too large, so we must swap
                // After swap, nums1[i] becomes currentNum2, and nums2[i] becomes currentNum1
                // Check if the swapped values satisfy the conditions
                if (currentNum2 <= target1 && currentNum1 <= target2) {
                    swaps++;
                } else {
                    // Swapping doesn't help or makes it worse, impossible
                    return Infinity;
                }
            }
        }
        return swaps;
    }

    // Scenario 1: nums1[n-1] and nums2[n-1] remain in their original positions
    // The targets for elements at i < n-1 are nums1[n-1] and nums2[n-1]
    const res1 = calculateSwaps(nums1[n - 1], nums2[n - 1]);

    // Scenario 2: nums1[n-1] and nums2[n-1] are swapped
    // The targets for elements at i < n-1 are nums2[n-1] and nums1[n-1]
    // This scenario costs 1 operation for the initial swap of the last elements
    let res2 = calculateSwaps(nums2[n - 1], nums1[n - 1]);
    if (res2 !== Infinity) {
        res2++; // Add 1 for the swap at index n-1
    }

    const minTotalOps = Math.min(res1, res2);

    return minTotalOps === Infinity ? -1 : minTotalOps;
};