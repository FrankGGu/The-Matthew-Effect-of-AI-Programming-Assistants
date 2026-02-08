use std::collections::BTreeSet;
use std::cmp::min;

impl Solution {
    pub fn min_absolute_difference(nums: Vec<i32>, x: i32) -> i32 {
        let n = nums.len();
        let x = x as usize;

        let mut min_diff = i32::MAX;
        let mut seen_elements = BTreeSet::new();

        for i in 0..n {
            // At index i, we are looking for nums[j] such that |i - j| >= x.
            // This means j <= i - x or j >= i + x.
            // We maintain elements nums[j] where j <= i - x in `seen_elements`.
            // When i reaches x, nums[0] becomes available for comparison.
            // When i reaches x+1, nums[1] becomes available, and so on.
            if i >= x {
                seen_elements.insert(nums[i - x]);
            }

            // If `seen_elements` is not empty, find the closest element to nums[i].
            // This means we are comparing nums[i] with nums[j] where j <= i - x.
            if !seen_elements.is_empty() {
                let current_num = nums[i];

                // Find the largest element in `seen_elements` that is less than or equal to `current_num`.
                if let Some(&le) = seen_elements.range(..=current_num).rev().next() {
                    min_diff = min(min_diff, current_num - le);
                }

                // Find the smallest element in `seen_elements` that is greater than or equal to `current_num`.
                if let Some(&ge) = seen_elements.range(current_num..).next() {
                    min_diff = min(min_diff, ge - current_num);
                }
            }
        }

        min_diff
    }
}