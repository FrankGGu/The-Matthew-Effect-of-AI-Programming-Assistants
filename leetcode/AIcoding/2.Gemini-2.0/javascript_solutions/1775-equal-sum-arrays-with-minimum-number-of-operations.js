var minOperations = function(nums1, nums2) {
    const sum1 = nums1.reduce((a, b) => a + b, 0);
    const sum2 = nums2.reduce((a, b) => a + b, 0);

    if (sum1 > 6 * nums2.length || sum2 > 6 * nums1.length) {
        return -1;
    }

    if (sum1 === sum2) {
        return 0;
    }

    if (sum1 < sum2) {
        return minOperations(nums2, nums1);
    }

    nums1.sort((a, b) => a - b);
    nums2.sort((a, b) => b - a);

    let i = 0;
    let j = 0;
    let diff = sum1 - sum2;
    let count = 0;

    while (diff > 0) {
        let change1 = i < nums1.length ? 6 - nums1[i] : 0;
        let change2 = j < nums2.length ? nums2[j] - 1 : 0;

        if (change1 === 0 && change2 === 0) return -1;

        if (change1 >= change2) {
            diff -= change1;
            i++;
        } else {
            diff -= change2;
            j++;
        }
        count++;
    }

    return count;
};