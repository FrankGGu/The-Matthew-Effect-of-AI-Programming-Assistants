var countBeautifulSplits = function(nums) {
    const n = nums.length;

    // According to the problem definition:
    // A split (nums1, nums2) is beautiful if:
    // 1. nums1 is a prefix of nums and nums2 is a suffix of nums.
    // 2. nums1 and nums2 are non-empty.
    // 3. The first element of nums1 is equal to the last element of nums2.

    // Let's analyze condition 3:
    // For any split, nums1 is nums[0...i] and nums2 is nums[i+1...n-1] for some valid i.
    // The first element of nums1 is always nums[0].
    // The last element of nums2 is always nums[n-1].
    // Therefore, the condition "the first element of nums1 is equal to the last element of nums2"
    // simplifies to nums[0] === nums[n-1].

    // This condition (nums[0] === nums[n-1]) is independent of the split point 'i'.
    // It is either true for all possible splits or false for all possible splits.

    if (nums[0] === nums[n - 1]) {
        // If nums[0] is equal to nums[n-1], then every valid split is beautiful.
        // We need to count the number of valid splits.
        // A split point 'i' means nums1 = nums[0...i] and nums2 = nums[i+1...n-1].
        // For nums1 to be non-empty, its length (i+1) must be at least 1, so i >= 0.
        // For nums2 to be non-empty, its length (n - (i+1)) must be at least 1, so n - i - 1 >= 1, which means i <= n - 2.
        // So, 'i' can range from 0 to n-2.
        // The number of possible integer values for 'i' in this range is (n-2) - 0 + 1 = n - 1.
        // Thus, there are n-1 beautiful splits.
        return n - 1;
    } else {
        // If nums[0] is not equal to nums[n-1], then no split can satisfy the beautiful condition.
        // So, there are 0 beautiful splits.
        return 0;
    }
};