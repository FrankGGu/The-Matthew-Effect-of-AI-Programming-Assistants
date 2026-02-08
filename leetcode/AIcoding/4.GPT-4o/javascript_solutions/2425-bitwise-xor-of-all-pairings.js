var xorAllNums = function(nums1, nums2) {
    const len1 = nums1.length, len2 = nums2.length;
    let result = 0;

    if (len1 % 2 === 1) {
        for (let num of nums2) {
            result ^= num;
        }
    }

    if (len2 % 2 === 1) {
        for (let num of nums1) {
            result ^= num;
        }
    }

    return result;
};