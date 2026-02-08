var minNumber = function(nums1, nums2) {
    const set1 = new Set(nums1);
    let common = Infinity;
    for (const num of nums2) {
        if (set1.has(num)) {
            common = Math.min(common, num);
        }
    }

    if (common !== Infinity) {
        return common;
    }

    const min1 = Math.min(...nums1);
    const min2 = Math.min(...nums2);

    return Math.min(min1 * 10 + min2, min2 * 10 + min1);
};