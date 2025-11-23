function minOperations(nums1, nums2) {
    const sum1 = nums1.reduce((a, b) => a + b, 0);
    const sum2 = nums2.reduce((a, b) => a + b, 0);

    if (sum1 === sum2) return 0;

    if (sum1 < sum2) {
        [nums1, nums2] = [nums2, nums1];
        [sum1, sum2] = [sum2, sum1];
    }

    nums1.sort((a, b) => b - a);
    nums2.sort((a, b) => a - b);

    let i = 0, j = 0, ops = 0;

    while (i < nums1.length || j < nums2.length) {
        const diff = sum1 - sum2;
        if (diff === 0) break;

        if (i < nums1.length && j < nums2.length) {
            const gain1 = nums1[i] - 1;
            const gain2 = 6 - nums2[j];
            if (gain1 >= gain2) {
                sum1 -= gain1;
                i++;
            } else {
                sum2 += gain2;
                j++;
            }
        } else if (i < nums1.length) {
            const gain1 = nums1[i] - 1;
            sum1 -= gain1;
            i++;
        } else {
            const gain2 = 6 - nums2[j];
            sum2 += gain2;
            j++;
        }
        ops++;
    }

    return ops;
}