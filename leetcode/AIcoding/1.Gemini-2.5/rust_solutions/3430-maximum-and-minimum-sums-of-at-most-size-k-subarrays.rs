use std::collections::VecDeque;

impl Solution {
    pub fn maximum_minimum_sums(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let k = k as usize;

        // Problem constraints state 1 <= nums.length <= 10^5, so n is never 0.
        // Problem constraints state 1 <= k <= n.

        let mut prefix_sums: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i] as i64;
        }

        // --- Calculate Maximum Sum ---
        let mut max_sum_val = i64::MIN;
        let mut deque_min_prefix_sum_indices: VecDeque<usize> = VecDeque::new();

        for j in 0..=n {
            // Remove indices from the front of the deque if they are too far left
            // to form a subarray of length at most k ending at `j-1`.
            // The starting index `i` for a subarray `nums[i..j-1]` must satisfy `j - i <= k`.
            // This means `i >= j - k`.
            while !deque_min_prefix_sum_indices.is_empty() && *deque_min_prefix_sum_indices.front().unwrap() < j.saturating_sub(k) {
                deque_min_prefix_sum_indices.pop_front();
            }

            // If the deque is not empty, the front element holds the index `i`
            // that minimizes `prefix_sums[i]` within the valid window `[j-k, j-1]`.
            // `prefix_sums[j] - prefix_sums[i]` gives the sum of `nums[i..j-1]`.
            if !deque_min_prefix_sum_indices.is_empty() {
                max_sum_val = max_sum_val.max(prefix_sums[j] - prefix_sums[*deque_min_prefix_sum_indices.front().unwrap()]);
            }

            // Maintain the deque such that `prefix_sums` values at stored indices are in increasing order.
            // This ensures `deque_min_prefix_sum_indices.front()` always points to the minimum `prefix_sums` value.
            while !deque_min_prefix_sum_indices.is_empty() && prefix_sums[*deque_min_prefix_sum_indices.back().unwrap()] >= prefix_sums[j] {
                deque_min_prefix_sum_indices.pop_back();
            }
            // Add the current index `j` to the back of the deque.
            deque_min_prefix_sum_indices.push_back(j);
        }

        // --- Calculate Minimum Sum ---
        let mut min_sum_val = i64::MAX;
        let mut deque_max_prefix_sum_indices: VecDeque<usize> = VecDeque::new();

        for j in 0..=n {
            // Remove indices from the front that are too far left (same window constraint as above).
            while !deque_max_prefix_sum_indices.is_empty() && *deque_max_prefix_sum_indices.front().unwrap() < j.saturating_sub(k) {
                deque_max_prefix_sum_indices.pop_front();
            }

            // If the deque is not empty, the front element holds the index `i`
            // that maximizes `prefix_sums[i]` within the valid window `[j-k, j-1]`.
            // `prefix_sums[j] - prefix_sums[i]` gives the sum of `nums[i..j-1]`.
            if !deque_max_prefix_sum_indices.is_empty() {
                min_sum_val = min_sum_val.min(prefix_sums[j] - prefix_sums[*deque_max_prefix_sum_indices.front().unwrap()]);
            }

            // Maintain the deque such that `prefix_sums` values at stored indices are in decreasing order.
            // This ensures `deque_max_prefix_sum_indices.front()` always points to the maximum `prefix_sums` value.
            while !deque_max_prefix_sum_indices.is_empty() && prefix_sums[*deque_max_prefix_sum_indices.back().unwrap()] <= prefix_sums[j] {
                deque_max_prefix_sum_indices.pop_back();
            }
            // Add the current index `j` to the back of the deque.
            deque_max_prefix_sum_indices.push_back(j);
        }

        max_sum_val + min_sum_val
    }
}