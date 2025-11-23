var minSwap = function(nums1, nums2) {
    const n = nums1.length;
    let swap = 0;
    let noSwap = 0;

    for (let i = 1; i < n; i++) {
        let newSwap = Infinity;
        let newNoSwap = Infinity;

        if (nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1]) {
            newSwap = Math.min(newSwap, swap + 1);
            newNoSwap = Math.min(newNoSwap, noSwap);
        }

        if (nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1]) {
            newSwap = Math.min(newSwap, noSwap + 1);
            newNoSwap = Math.min(newNoSwap, swap);
        }

        swap = newSwap;
        noSwap = newNoSwap;
    }

    return Math.min(swap, noSwap);
};