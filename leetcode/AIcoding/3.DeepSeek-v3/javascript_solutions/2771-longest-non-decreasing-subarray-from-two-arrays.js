var maxNonDecreasingLength = function(nums1, nums2) {
    const n = nums1.length;
    if (n === 0) return 0;

    let dp1 = 1, dp2 = 1;
    let res = 1;

    for (let i = 1; i < n; i++) {
        let newDp1 = 1, newDp2 = 1;

        if (nums1[i] >= nums1[i-1]) {
            newDp1 = Math.max(newDp1, dp1 + 1);
        }
        if (nums1[i] >= nums2[i-1]) {
            newDp1 = Math.max(newDp1, dp2 + 1);
        }

        if (nums2[i] >= nums1[i-1]) {
            newDp2 = Math.max(newDp2, dp1 + 1);
        }
        if (nums2[i] >= nums2[i-1]) {
            newDp2 = Math.max(newDp2, dp2 + 1);
        }

        dp1 = newDp1;
        dp2 = newDp2;
        res = Math.max(res, dp1, dp2);
    }

    return res;
};