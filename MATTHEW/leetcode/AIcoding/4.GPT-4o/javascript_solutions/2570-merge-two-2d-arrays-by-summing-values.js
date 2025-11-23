var mergeArrays = function(nums1, nums2) {
    const map = new Map();

    for (const [index, value] of nums1) {
        map.set(index, (map.get(index) || 0) + value);
    }

    for (const [index, value] of nums2) {
        map.set(index, (map.get(index) || 0) + value);
    }

    const result = Array.from(map.entries()).map(([index, value]) => [index, value]);
    result.sort((a, b) => a[0] - b[0]);

    return result;
};