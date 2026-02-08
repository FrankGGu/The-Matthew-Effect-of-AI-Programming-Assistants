var minSum = function(nums1, nums2, nums3, k) {
    const n = nums1.length;
    const values = [];

    for (let i = 0; i < n; i++) {
        values.push(BigInt(nums1[i]) + BigInt(nums2[i]) * BigInt(nums3[i]));
    }

    values.sort((a, b) => {
        if (a < b) return -1;
        if (a > b) return 1;
        return 0;
    });

    let totalSum = 0n;
    for (let i = 0; i < k; i++) {
        totalSum += values[i];
    }

    return totalSum;
};