use std::collections::HashMap;
use std::cmp::min;

impl Solution {
    pub fn min_sum_of_lengths(arr: Vec<i32>, target: i32) -> i32 {
        let n = arr.len();
        // dp[j] stores the minimum length of a sub-array with sum `target`
        // that ends at or before index `j`.
        let mut dp: Vec<i32> = vec![i32::MAX; n]; 

        // prefix_sum_map stores (prefix_sum, index) pairs.
        // We use usize::MAX to represent an index of -1,
        // indicating a sub-array starting from index 0.
        let mut prefix_sum_map: HashMap<i32, usize> = HashMap::new();
        prefix_sum_map.insert(0, usize::MAX); 

        let mut current_sum = 0;
        let mut min_total_len = i32::MAX;

        for j in 0..n {
            current_sum += arr[j];

            // Initialize dp[j] based on the minimum length found up to dp[j-1].
            // This ensures dp[j] always holds the minimum length of a valid sub-array
            // ending at or before j, even if no new valid sub-array ends exactly at j.
            if j > 0 {
                dp[j] = dp[j-1];
            }

            // Check if a sub-array ending at `j` with sum `target` exists.
            // This means `current_sum - target` must have been a prefix sum earlier.
            if let Some(&i_val) = prefix_sum_map.get(&(current_sum - target)) {
                let current_sub_array_len;
                if i_val == usize::MAX { // If i_val is usize::MAX, it means the sub-array starts from index 0.
                    current_sub_array_len = (j + 1) as i32;
                } else {
                    current_sub_array_len = (j - i_val) as i32;
                }

                // If a valid previous sub-array was found (ending at or before i_val)
                // and i_val is not usize::MAX (meaning it's a real index, not the dummy -1),
                // and dp[i_val] is not MAX (meaning a valid sub-array was actually found there),
                // then we can combine it with the current sub-array.
                if i_val != usize::MAX && dp[i_val] != i32::MAX {
                    min_total_len = min(min_total_len, current_sub_array_len + dp[i_val]);
                }

                // Update dp[j] with the length of the current sub-array ending at j,
                // if it's smaller than the current dp[j] (which might be dp[j-1]).
                dp[j] = min(dp[j], current_sub_array_len);
            }

            // Store the current prefix sum and its index.
            prefix_sum_map.insert(current_sum, j);
        }

        if min_total_len == i32::MAX {
            -1
        } else {
            min_total_len
        }
    }
}