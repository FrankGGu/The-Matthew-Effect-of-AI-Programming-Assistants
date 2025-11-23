use std::collections::HashSet;
use std::cmp::max;

impl Solution {
    fn max_subarray_sum_kadane(arr: &[i32]) -> i32 {
        if arr.is_empty() {
            return 0;
        }

        let mut max_so_far = arr[0];
        let mut current_max = arr[0];

        for i in 1..arr.len() {
            let num = arr[i];
            current_max = num.max(current_max + num);
            max_so_far = max_so_far.max(current_max);
        }

        max_so_far
    }

    // Optimized Kadane's that processes the original array and treats `val_to_remove` as a separator.
    // This avoids creating a new vector for each removal, but still iterates through the array.
    // Time complexity: O(N)
    fn max_subarray_sum_after_removal(nums: &[i32], val_to_remove: i32) -> i32 {
        let mut max_so_far = i32::MIN;
        let mut current_max = 0;
        let mut has_valid_element_in_segment = false; // Tracks if the current segment has any non-removed elements

        for &num in nums {
            if num == val_to_remove {
                // If we encounter the element to be removed, it acts as a separator.
                // The current subarray sum is broken.
                // We update max_so_far with the sum of the segment just ended (if it had valid elements).
                if has_valid_element_in_segment {
                    max_so_far = max_so_far.max(current_max);
                }
                current_max = 0; // Reset for the next segment
                has_valid_element_in_segment = false; // Reset segment status
            } else {
                has_valid_element_in_segment = true;
                current_max += num;
                // Update max_so_far with the maximum sum ending at the current position within the current segment.
                max_so_far = max_so_far.max(current_max);
            }
        }

        // After the loop, if max_so_far is still i32::MIN, it means:
        // 1. The input `nums` was empty (handled by main function).
        // 2. All elements in `nums` were `val_to_remove`, resulting in an empty effective array.
        // In this case, the maximum subarray sum is 0.
        // Otherwise, max_so_far holds the correct maximum.
        if max_so_far == i32::MIN {
            0
        } else {
            max_so_far
        }
    }

    pub fn maximize_subarray_sum_after_removing_all_occurrences_of_one_element(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut unique_elements = HashSet::new();
        for &num in &nums {
            unique_elements.insert(num);
        }

        // Initialize overall_max_sum to i32::MIN to correctly handle cases where all resulting sums are negative
        // (e.g., nums = [-5, -1, -3], remove -1 -> [-5, -3], max sum is -3).
        // If all elements are removed (e.g., nums = [5,5,5], remove 5), the max sum should be 0.
        // The `max_subarray_sum_after_removal` function handles this by returning 0 if no valid elements are processed.
        let mut overall_max_sum = i32::MIN;

        for &val_to_remove in &unique_elements {
            let current_max_sum = Self::max_subarray_sum_after_removal(&nums, val_to_remove);
            overall_max_sum = overall_max_sum.max(current_max_sum);
        }

        overall_max_sum
    }
}