use std::cmp;

impl Solution {
    pub fn max_non_decreasing_array_length(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();

        // If n is 0, no array can be formed, so length is 0.
        // Problem constraints usually guarantee n >= 1, but this handles the edge case.
        if n == 0 {
            return 0;
        }

        // prev_dp0 stores the maximum length of a non-decreasing subarray ending at the previous index (i-1),
        // where the element at (i-1) was chosen from nums1[i-1].
        // prev_dp1 stores the maximum length of a non-decreasing subarray ending at the previous index (i-1),
        // where the element at (i-1) was chosen from nums2[i-1].
        let mut prev_dp0 = 1;
        let mut prev_dp1 = 1;

        // max_overall_len keeps track of the maximum length found so far across all indices and choices.
        let mut max_overall_len = 1;

        // Iterate from the second element to the end of the arrays.
        for i in 1..n {
            // curr_dp0 will store the maximum length ending at the current index i,
            // where nums3[i] is chosen as nums1[i].
            // curr_dp1 will store the maximum length ending at the current index i,
            // where nums3[i] is chosen as nums2[i].
            // Initialize to 1, representing a new subarray starting at index i.
            let mut curr_dp0 = 1;
            let mut curr_dp1 = 1;

            // Calculate curr_dp0 (ending with nums1[i]):
            // Check if extending a subarray ending with nums1[i-1] is possible.
            if nums1[i-1] <= nums1[i] {
                curr_dp0 = cmp::max(curr_dp0, prev_dp0 + 1);
            }
            // Check if extending a subarray ending with nums2[i-1] is possible.
            if nums2[i-1] <= nums1[i] {
                curr_dp0 = cmp::max(curr_dp0, prev_dp1 + 1);
            }

            // Calculate curr_dp1 (ending with nums2[i]):
            // Check if extending a subarray ending with nums1[i-1] is possible.
            if nums1[i-1] <= nums2[i] {
                curr_dp1 = cmp::max(curr_dp1, prev_dp0 + 1);
            }
            // Check if extending a subarray ending with nums2[i-1] is possible.
            if nums2[i-1] <= nums2[i] {
                curr_dp1 = cmp::max(curr_dp1, prev_dp1 + 1);
            }

            // Update prev_dp0 and prev_dp1 for the next iteration.
            prev_dp0 = curr_dp0;
            prev_dp1 = curr_dp1;

            // Update the overall maximum length found so far.
            max_overall_len = cmp::max(max_overall_len, curr_dp0);
            max_overall_len = cmp::max(max_overall_len, curr_dp1);
        }

        max_overall_len
    }
}