var maximumScore = function(nums1, nums2, x) {
    let n = nums1.length;
    let totalSum1 = nums1.reduce((a, b) => a + b, 0);
    let totalSum2 = nums2.reduce((a, b) => a + b, 0);

    let maxScore = Math.max(totalSum1, totalSum2);

    for (let i = 0; i < n; i++) {
        let sum1 = totalSum1 - nums1[i];
        let sum2 = totalSum2 + nums1[i];
        if (sum2 <= x) {
            maxScore = Math.max(maxScore, sum1 + sum2);
        }

        sum1 = totalSum1 + nums2[i];
        sum2 = totalSum2 - nums2[i];
        if (sum1 <= x) {
            maxScore = Math.max(maxScore, sum1 + sum2);
        }
    }

    return maxScore;
};