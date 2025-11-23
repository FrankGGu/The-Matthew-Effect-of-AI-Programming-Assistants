var mergeArrays = function(nums1, nums2) {
    const map = new Map();

    for (const [id, val] of nums1) {
        map.set(id, val);
    }

    for (const [id, val] of nums2) {
        if (map.has(id)) {
            map.set(id, map.get(id) + val);
        } else {
            map.set(id, val);
        }
    }

    const result = Array.from(map.entries()).sort((a, b) => a[0] - b[0]);
    return result;
};