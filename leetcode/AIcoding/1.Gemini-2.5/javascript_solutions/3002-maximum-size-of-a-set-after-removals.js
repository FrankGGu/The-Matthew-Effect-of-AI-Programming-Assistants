var maximumSetSize = function(nums1, nums2) {
    const n = nums1.length;
    const half_n = n / 2;

    const set1 = new Set(nums1);
    const set2 = new Set(nums2);

    // Calculate the number of distinct elements we can effectively choose from nums1.
    // This is limited by the actual number of unique elements in nums1 (set1.size)
    // and the maximum number of elements we are allowed to keep from nums1 (half_n).
    const distinctFrom1 = Math.min(set1.size, half_n);

    // Similarly, calculate for nums2.
    const distinctFrom2 = Math.min(set2.size, half_n);

    // Calculate the total number of unique elements available across both arrays.
    // This is an upper bound on the final set size, as we cannot create new distinct elements.
    const totalUniqueAvailable = new Set([...nums1, ...nums2]).size;

    // The maximum possible size of the resulting set is limited by three factors:
    // 1. The total number of elements we pick, which is `n` (half_n from nums1 + half_n from nums2).
    // 2. The sum of the distinct elements we can pick from each array independently (`distinctFrom1 + distinctFrom2`).
    //    This sum represents an optimistic count, assuming no overlap.
    // 3. The actual total number of unique elements available in the combined pool (`totalUniqueAvailable`).
    //    If the optimistic sum (`distinctFrom1 + distinctFrom2`) exceeds `totalUniqueAvailable`,
    //    it means we are overcounting common elements, and the true maximum is `totalUniqueAvailable`.
    //    So, we take the minimum of the optimistic sum and `totalUniqueAvailable`.
    // The final result must then be capped by `n`.

    return Math.min(n, distinctFrom1 + distinctFrom2, totalUniqueAvailable);
};