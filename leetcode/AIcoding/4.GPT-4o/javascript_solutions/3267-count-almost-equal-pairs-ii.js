var countAlmostEqualPairs = function(nums1, nums2) {
    const n = nums1.length;
    const map = new Map();
    let count = 0;

    for (let i = 0; i < n; i++) {
        const diff = nums1[i] - nums2[i];
        count += map.get(diff) || 0;

        for (let j = -1; j <= 1; j++) {
            map.set(diff + j, (map.get(diff + j) || 0) + 1);
        }
    }

    return count;
};