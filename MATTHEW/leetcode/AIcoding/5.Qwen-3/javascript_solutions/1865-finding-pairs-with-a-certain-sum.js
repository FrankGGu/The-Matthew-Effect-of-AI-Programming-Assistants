function findSumPairs(nums1, nums2, target) {
    const map = new Map();
    for (const num of nums2) {
        map.set(num, (map.get(num) || 0) + 1);
    }
    let count = 0;
    for (const num of nums1) {
        const complement = target - num;
        if (map.has(complement)) {
            count += map.get(complement);
        }
    }
    return count;
}