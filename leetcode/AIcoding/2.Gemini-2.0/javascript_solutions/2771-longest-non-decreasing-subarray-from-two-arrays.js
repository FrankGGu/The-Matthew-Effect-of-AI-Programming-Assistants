var maxNonDecreasingLength = function(nums1, nums2) {
    const n = nums1.length;
    let dp1 = new Array(n).fill(1);
    let dp2 = new Array(n).fill(1);
    let ans = 1;

    for (let i = 1; i < n; i++) {
        if (nums1[i] >= nums1[i - 1]) {
            dp1[i] = Math.max(dp1[i], dp1[i - 1] + 1);
        }
        if (nums1[i] >= nums2[i - 1]) {
            dp1[i] = Math.max(dp1[i], dp2[i - 1] + 1);
        }
        if (nums2[i] >= nums1[i - 1]) {
            dp2[i] = Math.max(dp2[i], dp1[i - 1] + 1);
        }
        if (nums2[i] >= nums2[i - 1]) {
            dp2[i] = Math.max(dp2[i], dp2[i - 1] + 1);
        }
        ans = Math.max(ans, dp1[i], dp2[i]);
    }

    return ans;
};