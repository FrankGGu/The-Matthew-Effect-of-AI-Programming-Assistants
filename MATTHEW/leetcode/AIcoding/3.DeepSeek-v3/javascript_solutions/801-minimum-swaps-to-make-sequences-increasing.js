var minSwap = function(nums1, nums2) {
    const n = nums1.length;
    let swap = 1, noSwap = 0;

    for (let i = 1; i < n; i++) {
        let newSwap = Infinity, newNoSwap = Infinity;
        if (nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1]) {
            newNoSwap = Math.min(newNoSwap, noSwap);
            newSwap = Math.min(newSwap, swap + 1);
        }
        if (nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1]) {
            newNoSwap = Math.min(newNoSwap, swap);
            newSwap = Math.min(newSwap, noSwap + 1);
        }
        swap = newSwap;
        noSwap = newNoSwap;
    }

    return Math.min(swap, noSwap);
};