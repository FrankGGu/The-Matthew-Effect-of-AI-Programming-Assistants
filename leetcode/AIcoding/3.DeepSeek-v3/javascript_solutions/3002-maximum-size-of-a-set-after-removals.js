var maximumSetSize = function(nums1, nums2) {
    const set1 = new Set(nums1);
    const set2 = new Set(nums2);
    const common = new Set([...set1].filter(x => set2.has(x)));
    const unique1 = set1.size - common.size;
    const unique2 = set2.size - common.size;
    const n = nums1.length;
    const maxUnique1 = Math.min(unique1, n / 2);
    const maxUnique2 = Math.min(unique2, n / 2);
    const remaining = Math.max(0, n / 2 - maxUnique1) + Math.max(0, n / 2 - maxUnique2);
    const maxCommon = Math.min(common.size, remaining);
    return maxUnique1 + maxUnique2 + maxCommon;
};