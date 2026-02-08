var minimumTotalCost = function(nums1, nums2, cost) {
    let totalCost = 0;

    // Iterate through each index
    for (let i = 0; i < nums1.length; i++) {
        // If nums1[i] is equal to nums2[i], we must perform an operation at this index.
        // The problem states that cost[i] is the cost to change either nums1[i] or nums2[i]
        // to any other integer. Since we can change it to "any other integer", we can always
        // pick a value that resolves the conflict at index i without creating new conflicts
        // at other indices or affecting existing non-conflicting indices.
        // For example, if nums1[i] == nums2[i] == V, we can change nums1[i] to V+1.
        // This operation costs cost[i].
        // This implies that for every index where nums1[i] == nums2[i], we simply add cost[i]
        // to our total.
        if (nums1[i] === nums2[i]) {
            totalCost += cost[i];
        }
    }

    // The problem statement includes "If it is impossible, return -1."
    // Given that we can change an element to "any other integer", it is always possible
    // to make nums1[i] != nums2[i] at any given index i. Therefore, it is always possible
    // to satisfy the condition for all indices. The "-1" case is unreachable under this interpretation.

    return totalCost;
};