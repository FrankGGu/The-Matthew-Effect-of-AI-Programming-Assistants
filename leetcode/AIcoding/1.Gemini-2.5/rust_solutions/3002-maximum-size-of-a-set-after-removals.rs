use std::collections::HashSet;

impl Solution {
    pub fn maximum_set_size(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len() as i32;
        let n_half = n / 2;

        let s1: HashSet<i32> = nums1.into_iter().collect();
        let s2: HashSet<i32> = nums2.into_iter().collect();

        let s1_only_count = s1.difference(&s2).count() as i32;
        let s2_only_count = s2.difference(&s1).count() as i32;
        let common_count = s1.intersection(&s2).count() as i32;

        let mut result = 0;

        // Step 1: Maximize picking unique elements from nums1 that are not in nums2.
        // We can pick at most n_half elements from nums1.
        let picked_s1_only = s1_only_count.min(n_half);
        result += picked_s1_only;
        let n_half_remaining_for_s1 = n_half - picked_s1_only;

        // Step 2: Maximize picking unique elements from nums2 that are not in nums1.
        // We can pick at most n_half elements from nums2.
        let picked_s2_only = s2_only_count.min(n_half);
        result += picked_s2_only;
        let n_half_remaining_for_s2 = n_half - picked_s2_only;

        // Step 3: Use remaining "slots" from n_half picks to pick common elements.
        // The total number of common elements we can add is limited by:
        // 1. The actual number of common unique elements (common_count).
        // 2. The sum of remaining slots from nums1 and nums2.
        let picked_common = common_count.min(n_half_remaining_for_s1 + n_half_remaining_for_s2);
        result += picked_common;

        // The calculated result will never exceed n (total elements kept),
        // because picked_s1_only + picked_s2_only + picked_common
        // <= picked_s1_only + picked_s2_only + (n_half - picked_s1_only) + (n_half - picked_s2_only)
        // = n_half + n_half = n.
        result
    }
}