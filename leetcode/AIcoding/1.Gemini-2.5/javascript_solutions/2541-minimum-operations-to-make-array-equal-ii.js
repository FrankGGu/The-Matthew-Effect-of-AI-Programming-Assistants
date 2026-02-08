var minimumOperations = function(nums1, nums2, k) {
    let n = nums1.length;
    let totalDiffPositive = 0;
    let totalDiffNegative = 0;

    for (let i = 0; i < n; i++) {
        let diff = nums1[i] - nums2[i];

        if (diff === 0) {
            continue;
        }

        if (k === 0) {
            return -1;
        }

        if (diff % k !== 0) {
            return -1;
        }

        if (diff > 0) {
            totalDiffPositive += diff;
        } else { // diff < 0
            totalDiffNegative += diff;
        }
    }

    if (k === 0) {
        return 0;
    }

    if (totalDiffPositive + totalDiffNegative !== 0) {
        return -1;
    }

    return totalDiffPositive / k;
};