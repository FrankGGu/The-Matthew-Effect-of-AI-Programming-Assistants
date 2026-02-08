use std::cmp::{min, max};

impl Solution {
    pub fn min_absolute_sum_diff(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let mut sorted_nums1 = nums1.clone();
        sorted_nums1.sort_unstable();

        let modulo = 1_000_000_007;

        let mut total_diff_sum: i64 = 0;
        let mut max_reduction: i64 = 0;

        for i in 0..n {
            let val1 = nums1[i];
            let val2 = nums2[i];

            let original_diff = (val1 - val2).abs() as i64;
            total_diff_sum = (total_diff_sum + original_diff) % modulo;

            let mut current_min_new_diff: i64 = original_diff; // Initialize with current diff as a baseline

            match sorted_nums1.binary_search(&val2) {
                Ok(_) => {
                    // val2 is found in sorted_nums1, so we can make the diff 0
                    current_min_new_diff = 0;
                }
                Err(idx) => {
                    // val2 is not found, idx is the insertion point
                    if idx > 0 {
                        // Check element to the left of insertion point
                        let candidate_val = sorted_nums1[idx - 1];
                        current_min_new_diff = min(current_min_new_diff, (candidate_val - val2).abs() as i64);
                    }
                    if idx < n {
                        // Check element at insertion point (to the right)
                        let candidate_val = sorted_nums1[idx];
                        current_min_new_diff = min(current_min_new_diff, (candidate_val - val2).abs() as i64);
                    }
                }
            }

            // The reduction achieved by replacing nums1[i] is original_diff - current_min_new_diff
            // We want to maximize this reduction across all possible replacements.
            max_reduction = max(max_reduction, original_diff - current_min_new_diff);
        }

        // The final result is (total_diff_sum - max_reduction) modulo MOD
        // Add `modulo` before taking modulo to handle potential negative results from subtraction.
        let result = (total_diff_sum - max_reduction + modulo) % modulo;

        result as i32
    }
}