impl Solution {
    pub fn max_sum_two_no_overlap(nums: Vec<i32>, first_len: i32, second_len: i32) -> i32 {
        let n = nums.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        // Helper function to calculate the maximum sum of two non-overlapping subarrays
        // where the subarray of length `l1_len` appears *before* the subarray of length `l2_len`.
        fn calculate_max_sum_ordered(
            n: usize,
            prefix_sum: &[i32],
            l1_len: usize,
            l2_len: usize,
        ) -> i32 {
            let mut max_total_sum = 0;
            // max_l1_sum_so_far tracks the maximum sum of an L1-length subarray
            // that ends at or before 'j - l2_len' (i.e., strictly before the current L2-length subarray starts).
            let mut max_l1_sum_so_far = 0;

            // Iterate through all possible ending positions 'j' for the second subarray (L2-length).
            // The second subarray must have at least 'l2_len' elements.
            // The first subarray must have at least 'l1_len' elements and come before the second.
            // So, the total length must be at least 'l1_len + l2_len'.
            // The earliest 'j' can be is 'l1_len + l2_len - 1'.
            for j in (l1_len + l2_len - 1)..n {
                // Calculate the sum of the L1-length subarray that ends at 'j - l2_len'.
                // This is the latest possible L1-length subarray that is non-overlapping
                // and appears before the current L2-length subarray.
                let l1_candidate_end_idx = j - l2_len;
                let current_l1_sum =
                    prefix_sum[l1_candidate_end_idx + 1] - prefix_sum[l1_candidate_end_idx - l1_len + 1];

                // Update max_l1_sum_so_far with the maximum L1 sum found so far
                // that ends before the current L2 subarray.
                max_l1_sum_so_far = max_l1_sum_so_far.max(current_l1_sum);

                // Calculate the sum of the current L2-length subarray ending at 'j'.
                let current_l2_sum = prefix_sum[j + 1] - prefix_sum[j - l2_len + 1];

                // Update the overall maximum total sum.
                max_total_sum = max_total_sum.max(max_l1_sum_so_far + current_l2_sum);
            }
            max_total_sum
        }

        let l1 = first_len as usize;
        let l2 = second_len as usize;

        // Case 1: The `first_len` subarray appears before the `second_len` subarray.
        let res1 = calculate_max_sum_ordered(n, &prefix_sum, l1, l2);

        // Case 2: The `second_len` subarray appears before the `first_len` subarray.
        let res2 = calculate_max_sum_ordered(n, &prefix_sum, l2, l1);

        // The overall maximum is the greater of the two cases.
        res1.max(res2)
    }
}