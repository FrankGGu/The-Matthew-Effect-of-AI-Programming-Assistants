var minSwap = function(nums1, nums2) {
    const n = nums1.length;

    // dp_no_swap represents the minimum swaps to make sequences increasing up to the current index,
    // with the current elements (nums1[i], nums2[i]) NOT swapped.
    let dp_no_swap = 0;

    // dp_swap represents the minimum swaps to make sequences increasing up to the current index,
    // with the current elements (nums1[i], nums2[i]) SWAPPED.
    let dp_swap = 1;

    for (let i = 1; i < n; i++) {
        let next_no_swap = Infinity;
        let next_swap = Infinity;

        // Case 1: If current elements can maintain order with previous elements maintaining order.
        // i.e., nums1[i] > nums1[i-1] and nums2[i] > nums2[i-1]
        if (nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1]) {
            // If previous elements were not swapped, current elements also not swapped.
            next_no_swap = Math.min(next_no_swap, dp_no_swap);
            // If previous elements were swapped, current elements are swapped.
            next_swap = Math.min(next_swap, dp_swap + 1);
        }

        // Case 2: If current elements can maintain order with previous elements having swapped order.
        // i.e., nums1[i] > nums2[i-1] and nums2[i] > nums1[i-1]
        if (nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1]) {
            // If previous elements were not swapped, current elements are swapped.
            next_swap = Math.min(next_swap, dp_no_swap + 1);
            // If previous elements were swapped, current elements are not swapped.
            next_no_swap = Math.min(next_no_swap, dp_swap);
        }

        dp_no_swap = next_no_swap;
        dp_swap = next_swap;
    }

    return Math.min(dp_no_swap, dp_swap);
};