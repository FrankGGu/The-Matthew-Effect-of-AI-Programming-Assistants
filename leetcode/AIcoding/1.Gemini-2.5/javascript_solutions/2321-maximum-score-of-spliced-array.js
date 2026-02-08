var maximumsSplicedArray = function(nums1, nums2) {
    const n = nums1.length;
    let sum1 = 0;
    let sum2 = 0;
    const diff1 = new Array(n); // Represents nums2[i] - nums1[i]
    const diff2 = new Array(n); // Represents nums1[i] - nums2[i]

    for (let i = 0; i < n; i++) {
        sum1 += nums1[i];
        sum2 += nums2[i];
        diff1[i] = nums2[i] - nums1[i];
        diff2[i] = nums1[i] - nums2[i];
    }

    const kadane = (arr) => {
        let maxSoFar = 0;
        let globalMax = 0;
        for (let i = 0; i < arr.length; i++) {
            maxSoFar = Math.max(arr[i], maxSoFar + arr[i]);
            globalMax = Math.max(globalMax, maxSoFar);
        }
        return globalMax;
    };

    const maxDiff1Sum = kadane(diff1);
    const maxDiff2Sum = kadane(diff2);

    return Math.max(sum1 + maxDiff1Sum, sum2 + maxDiff2Sum);
};