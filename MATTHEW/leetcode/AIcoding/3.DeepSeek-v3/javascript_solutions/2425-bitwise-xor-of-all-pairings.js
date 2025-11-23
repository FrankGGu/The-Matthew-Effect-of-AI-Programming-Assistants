var xorAllNums = function(nums1, nums2) {
    let result = 0;
    const len1 = nums1.length;
    const len2 = nums2.length;

    if (len2 % 2 !== 0) {
        for (const num of nums1) {
            result ^= num;
        }
    }

    if (len1 % 2 !== 0) {
        for (const num of nums2) {
            result ^= num;
        }
    }

    return result;
};