var maximumsSplicedArray = function(nums1, nums2) {
    const n = nums1.length;
    let sum1 = 0, sum2 = 0;
    for (let i = 0; i < n; i++) {
        sum1 += nums1[i];
        sum2 += nums2[i];
    }

    let maxDiff1 = 0, maxDiff2 = 0;
    let currentDiff1 = 0, currentDiff2 = 0;

    for (let i = 0; i < n; i++) {
        const diff = nums2[i] - nums1[i];
        currentDiff1 = Math.max(diff, currentDiff1 + diff);
        maxDiff1 = Math.max(maxDiff1, currentDiff1);

        const diff2 = nums1[i] - nums2[i];
        currentDiff2 = Math.max(diff2, currentDiff2 + diff2);
        maxDiff2 = Math.max(maxDiff2, currentDiff2);
    }

    return Math.max(sum1 + maxDiff1, sum2 + maxDiff2);
};