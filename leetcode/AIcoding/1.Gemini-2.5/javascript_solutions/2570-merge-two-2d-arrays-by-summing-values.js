var mergeArrays = function(nums1, nums2) {
    const map = new Map();

    for (const [id, value] of nums1) {
        map.set(id, value);
    }

    for (const [id, value] of nums2) {
        map.set(id, (map.get(id) || 0) + value);
    }

    const result = [];
    for (const [id, value] of map) {
        result.push([id, value]);
    }

    result.sort((a, b) => a[0] - b[0]);

    return result;
};