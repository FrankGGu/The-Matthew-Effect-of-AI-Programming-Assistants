var minOperations = function(nums1, nums2, k) {
    let posDiff = 0, negDiff = 0;
    for (let i = 0; i < nums1.length; i++) {
        let diff = nums1[i] - nums2[i];
        if (k === 0) {
            if (diff !== 0) return -1;
            continue;
        }
        if (diff % k !== 0) return -1;
        if (diff > 0) {
            posDiff += diff / k;
        } else {
            negDiff += diff / k;
        }
    }
    if (k === 0) return 0;
    if (posDiff + negDiff !== 0) return -1;
    return Math.abs(posDiff);
};