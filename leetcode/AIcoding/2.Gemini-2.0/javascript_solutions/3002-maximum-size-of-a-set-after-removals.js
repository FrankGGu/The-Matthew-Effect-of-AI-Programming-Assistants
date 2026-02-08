var maximumSetSize = function(nums1, nums2) {
    const set1 = new Set(nums1);
    const set2 = new Set(nums2);
    const intersection = new Set([...set1].filter(x => set2.has(x)));

    const unique1 = set1.size - intersection.size;
    const unique2 = set2.size - intersection.size;
    const common = intersection.size;

    let ans = 0;
    const n = nums1.length;

    const takeFrom1 = Math.min(unique1, Math.floor(n / 2));
    ans += takeFrom1;

    const takeFrom2 = Math.min(unique2, Math.floor(n / 2) - takeFrom1);
    ans += takeFrom2;

    const remaining = n - takeFrom1 - takeFrom2;
    ans += Math.min(common, remaining);

    return ans;
};