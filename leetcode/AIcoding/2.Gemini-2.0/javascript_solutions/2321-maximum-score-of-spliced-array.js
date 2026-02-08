var maximumsSplicedArray = function(nums1, nums2) {
    const n = nums1.length;
    let sum1 = 0;
    let sum2 = 0;

    for (let i = 0; i < n; i++) {
        sum1 += nums1[i];
        sum2 += nums2[i];
    }

    let maxDiff1 = 0;
    let currDiff1 = 0;
    for (let i = 0; i < n; i++) {
        currDiff1 += nums2[i] - nums1[i];
        maxDiff1 = Math.max(maxDiff1, currDiff1);
        if (currDiff1 < 0) {
            currDiff1 = 0;
        }
    }

    let maxDiff2 = 0;
    let currDiff2 = 0;
    for (let i = 0; i < n; i++) {
        currDiff2 += nums1[i] - nums2[i];
        maxDiff2 = Math.max(maxDiff2, currDiff2);
        if (currDiff2 < 0) {
            currDiff2 = 0;
        }
    }

    return Math.max(sum1 + maxDiff1, sum2 + maxDiff2);
};