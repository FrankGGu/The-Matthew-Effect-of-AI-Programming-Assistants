var countAlmostEqualPairs = function(nums1, nums2, diff) {
    let n = nums1.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (Math.abs(nums1[i] - nums1[j]) <= diff && Math.abs(nums2[i] - nums2[j]) <= diff) {
                count++;
            }
        }
    }

    return count;
};