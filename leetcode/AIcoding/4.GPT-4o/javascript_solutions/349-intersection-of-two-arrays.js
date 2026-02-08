var intersection = function(nums1, nums2) {
    const set1 = new Set(nums1);
    const set2 = new Set(nums2);
    const result = [...set1].filter(num => set2.has(num));
    return result;
};