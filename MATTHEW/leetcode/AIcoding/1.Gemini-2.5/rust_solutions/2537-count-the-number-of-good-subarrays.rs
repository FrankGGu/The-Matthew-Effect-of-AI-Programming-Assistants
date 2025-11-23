use std::collections::HashMap;

impl Solution {
    pub fn count_good_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let total_subarrays = (n as i64) * (n as i64 + 1) / 2;

        // The problem asks for the number of subarrays with at least k pairs.
        // This can be calculated as:
        // (Total number of subarrays) - (Number of subarrays with less than k pairs)
        // Subarrays with less than k pairs are those with at most (k-1) pairs.
        let subarrays_with_less_than_k_pairs = Self::count_subarrays_with_at_most_k_pairs(&nums, k - 1);

        total_subarrays - subarrays_with_less_than_k_pairs
    }

    // Helper function to count subarrays with at most `k_limit` pairs.
    fn count_subarrays_with_at_most_k_pairs(nums: &[i32], k_limit: i32) -> i64 {
        let n = nums.len();
        let mut ans: i64 = 0;
        let mut left: usize = 0;
        let mut freq: HashMap<i32, i32> = HashMap::new();
        let mut current_pairs: i64 = 0;

        for right in 0..n {
            let val = nums[right];

            // When adding nums[right] to the window, it forms new pairs
            // with all existing occurrences of `val` already in the window.
            // If `val` has appeared `c` times before, it forms `c` new pairs.
            current_pairs += *freq.get(&val).unwrap_or(&0) as i64;
            *freq.entry(val).or_insert(0) += 1;

            // If the current window [left, right] has more than `k_limit` pairs,
            // shrink the window from the left until the condition is met.
            while current_pairs > k_limit as i64 {
                let val_left = nums[left];

                // When removing nums[left] from the window, it stops forming pairs
                // with the remaining occurrences of `val_left`.
                // If `val_left` appeared `c` times (before decrementing), it contributed
                // `c-1` pairs with other `val_left`s. After removing one, it contributes
                // `c-2` pairs (if `c > 1`). So we subtract the new count (`c-1`) from `current_pairs`.
                *freq.entry(val_left).or_insert(0) -= 1;
                current_pairs -= *freq.get(&val_left).unwrap_or(&0) as i64;
                left += 1;
            }

            // At this point, the window `[left, right]` satisfies the condition
            // (i.e., `current_pairs <= k_limit`).
            // All subarrays ending at `right` and starting from any index
            // between `left` and `right` (inclusive) will also satisfy the condition.
            // This is because removing elements from the left end of a valid window
            // can only decrease or keep the number of pairs the same.
            // The number of such subarrays is `right - left + 1`.
            ans += (right - left + 1) as i64;
        }

        ans
    }
}