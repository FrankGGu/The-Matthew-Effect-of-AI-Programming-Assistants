use std::collections::HashMap;
use std::cmp::min;

impl Solution {
    pub fn min_size_subarray_in_infinite_array(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        let s: i64 = nums.iter().map(|&x| x as i64).sum();

        // Initialize minimum length to a very large value
        let mut min_total_len = i32::MAX;

        // Calculate the number of full `nums` arrays that fit into `target`
        let num_full_arrays = (target as i64) / s;
        // Calculate the remaining target sum after accounting for full arrays
        let remaining_target = (target as i64) % s;

        // Create an extended array by concatenating `nums` with itself.
        // This allows us to find subarrays that wrap around the original `nums` array boundary,
        // up to a length of `2 * N`.
        let mut extended_nums = Vec::with_capacity(2 * n);
        extended_nums.extend_from_slice(&nums);
        extended_nums.extend_from_slice(&nums);

        // This helper function finds the minimum length subarray in `extended_nums`
        // that sums to `target_sum`. It uses a prefix sum approach with a hash map.
        // Returns `i32::MAX` if no such subarray is found.
        let find_min_len_subarray = |target_sum: i64| -> i32 {
            let mut current_sum: i64 = 0;
            let mut prefix_sums: HashMap<i64, i32> = HashMap::new();
            prefix_sums.insert(0, -1); // Base case: sum 0 is before index -1

            let mut min_len_for_t = i32::MAX;

            for (i, &num) in extended_nums.iter().enumerate() {
                current_sum += num as i64;
                // If `current_sum - target_sum` exists in the map, a subarray sums to `target_sum`
                if let Some(&prev_idx) = prefix_sums.get(&(current_sum - target_sum)) {
                    min_len_for_t = min(min_len_for_t, i as i32 - prev_idx);
                }
                // Store the first occurrence of a prefix sum to ensure minimum length
                prefix_sums.entry(current_sum).or_insert(i as i32);
            }
            min_len_for_t
        };

        // Case 1: The solution uses `num_full_arrays` full `nums` blocks and a subarray
        // from `extended_nums` that sums to `remaining_target`.
        let len_for_remaining = find_min_len_subarray(remaining_target);
        if len_for_remaining != i32::MAX {
            min_total_len = min(min_total_len, (num_full_arrays * n as i64 + len_for_remaining as i64) as i32);
        }

        // Case 2: The solution uses `num_full_arrays - 1` full `nums` blocks (if `num_full_arrays > 0`)
        // and a subarray from `extended_nums` that sums to `remaining_target + s`.
        // This accounts for situations where the optimal subarray might "borrow" elements
        // from what would have been the next full `nums` block to form a shorter remainder.
        // This is only relevant if `num_full_arrays` is at least 1, or if `target` itself is less than `s`
        // (in which case `num_full_arrays` is 0, and `remaining_target` is `target`).
        // However, `find_min_len_subarray(target)` already covers the `num_full_arrays = 0` case.
        // So we only need to consider `num_full_arrays - 1` if `num_full_arrays > 0`.
        if num_full_arrays > 0 {
            let len_for_remaining_plus_s = find_min_len_subarray(remaining_target + s);
            if len_for_remaining_plus_s != i32::MAX {
                min_total_len = min(min_total_len, ((num_full_arrays - 1) * n as i64 + len_for_remaining_plus_s as i64) as i32);
            }
        }

        // If no subarray was found, return -1. Otherwise, return the minimum length.
        if min_total_len == i32::MAX {
            -1
        } else {
            min_total_len
        }
    }
}