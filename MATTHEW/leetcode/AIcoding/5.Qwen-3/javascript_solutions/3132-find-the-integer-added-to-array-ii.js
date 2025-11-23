function findGoodInteger(nums1, nums2) {
    const map = new Map();
    for (const num of nums1) {
        map.set(num, (map.get(num) || 0) + 1);
    }
    for (const num of nums2) {
        if (map.has(num)) {
            return num;
        }
    }
    return -1;
}