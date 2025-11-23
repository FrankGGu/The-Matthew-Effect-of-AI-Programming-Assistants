var minNumber = function(nums1, nums2) {
    const set1 = new Set(nums1);
    const set2 = new Set(nums2);
    let common = [];
    for (let num of set1) {
        if (set2.has(num)) {
            common.push(num);
        }
    }
    if (common.length > 0) {
        return Math.min(...common);
    }
    const min1 = Math.min(...nums1);
    const min2 = Math.min(...nums2);
    return min1 < min2 ? min1 * 10 + min2 : min2 * 10 + min1;
};