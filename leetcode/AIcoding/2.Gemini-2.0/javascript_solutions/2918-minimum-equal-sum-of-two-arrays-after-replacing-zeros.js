var minSum = function(nums1, nums2) {
    let sum1 = 0, sum2 = 0;
    let zeros1 = 0, zeros2 = 0;

    for (let num of nums1) {
        sum1 += num;
        if (num === 0) {
            zeros1++;
        }
    }

    for (let num of nums2) {
        sum2 += num;
        if (num === 0) {
            zeros2++;
        }
    }

    if (sum1 + zeros1 < sum2 + zeros2 && zeros1 === 0) return -1;
    if (sum2 + zeros2 < sum1 + zeros1 && zeros2 === 0) return -1;

    return Math.max(sum1 + zeros1, sum2 + zeros2);
};