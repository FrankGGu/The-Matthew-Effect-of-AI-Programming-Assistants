use std::collections::{BTreeMap, HashMap};
use std::f64;

const EPSILON: f64 = 1e-9; 

impl Solution {
    pub fn max_subarray_with_equal_products(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let mut max_overall_len = 0;

        // Step 1: Handle subarrays containing zeros
        // If a subarray `nums[i..j]` contains at least two zeros, say at `z1` and `z2`
        // where `i <= z1 <= k` and `k+1 <= z2 <= j`, then `prod(nums[i..k]) == 0` and `prod(nums[k+1..j]) == 0`.
        // This means any subarray containing at least two zeros can be split to satisfy the condition.
        // The maximum length for this case would be the length of the subarray from the first zero to the last zero.
        let mut zero_indices = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == 0 {
                zero_indices.push(i);
            }
        }

        if zero_indices.len() >= 2 {
            max_overall_len = zero_indices.last().unwrap() - zero_indices[0] + 1;
        }

        // Step 2: Process segments without zeros
        // If a subarray `nums[i..j]` contains exactly one zero, it cannot be split to satisfy the condition
        // because one part's product will be zero and the other's will be non-zero.
        // Thus, we only need to consider subarrays that do not contain any zeros.
        // We split the original array by zeros and process each zero-free segment.
        let mut current_segment_start = 0;
        for &zero_idx in zero_indices.iter() {
            if zero_idx > current_segment_start {
                let segment = &nums[current_segment_start..zero_idx];
                max_overall_len = max_overall_len.max(Self::solve_zero_free_segment(segment));
            }
            current_segment_start = zero_idx + 1;
        }
        // Process the last segment (after the last zero, or the whole array if no zeros)
        if current_segment_start < n {
            let segment = &nums[current_segment_start..n];
            max_overall_len = max_overall_len.max(Self::solve_zero_free_segment(segment));
        }

        max_overall_len as i32
    }

    // Solves the problem for a segment of numbers that do not contain any zeros.
    // Uses logarithms to handle large products and BTreeMap for approximate float lookups.
    fn solve_zero_free_segment(segment: &[i32]) -> usize {
        let n_seg = segment.len();
        if n_seg < 2 {
            return 0;
        }

        let mut max_len_seg = 0;

        // Precompute logarithms of absolute values and negative sign parities
        let mut log_abs_nums: Vec<f64> = Vec::with_capacity(n_seg);
        let mut neg_signs: Vec<i32> = Vec::with_capacity(n_seg); // 1 if negative, 0 if positive

        for &num in segment.iter() {
            log_abs_nums.push((num as f64).abs().ln());
            neg_signs.push(if num < 0 { 1 } else { 0 });
        }

        // Iterate through all possible split points `k` within the segment.
        // `k` is the last index of the left part `segment[i..k]`.
        // `k+1` is the first index of the right part `segment[k+1..j]`.
        for k in 0..n_seg - 1 {
            // `map_left` stores `log_sum` as key and an inner `HashMap` for `neg_parity` to `smallest_i_index`.
            // `BTreeMap` is used for `log_sum` to allow range queries for approximate float comparison.
            let mut map_left: BTreeMap<f64, HashMap<i32, usize>> = BTreeMap::new();

            // Initialize `map_left` with an entry for an empty left part.
            // An empty part has product 1, log_sum 0.0, and negative parity 0.
            // The 'start index' `i` for this empty part, if it ends at `k`, means the part
            // is `segment[k+1..k]`, effectively starting at `k+1`.
            map_left.entry(0.0).or_default().entry(0).or_insert(k + 1);

            let mut current_log_sum_left = 0.0;
            let mut current_neg_parity_left = 0;

            // Iterate `i` from `k` down to `0` to build products for the left part `segment[i..k]`.
            for i in (0..=k).rev() {
                current_log_sum_left += log_abs_nums[i];
                current_neg_parity_left = (current_neg_parity_left + neg_signs[i]) % 2;

                // Store the smallest `i` for a given `(log_sum, neg_parity)` pair to maximize the length `j - i + 1`.
                let entry = map_left
                    .entry(current_log_sum_left)
                    .or_default()
                    .entry(current_neg_parity_left)
                    .or_insert(i);
                *entry = (*entry).min(i); 
            }

            let mut current_log_sum_right = 0.0;
            let mut current_neg_parity_right = 0;

            // Iterate `j` from `k+1` to `n_seg-1` to build products for the right part `segment[k+1..j]`.
            for j in k + 1..n_seg {
                current_log_sum_right += log_abs_nums[j];
                current_neg_parity_right = (current_neg_parity_right + neg_signs[j]) % 2;

                // Search for `current_log_sum_right` in `map_left` with `EPSILON` tolerance.
                // The `range` method on `BTreeMap` allows iterating over keys within a specified range.
                let lower_bound = current_log_sum_right - EPSILON;
                let upper_bound = current_log_sum_right + EPSILON;

                for (&log_key, inner_map) in map_left.range(lower_bound..=upper_bound) {
                    // Double-check the float comparison to ensure it's within EPSILON,
                    // as `BTreeMap::range` uses strict ordering, not approximate.
                    if (log_key - current_log_sum_right).abs() < EPSILON {
                        if let Some(&i_val) = inner_map.get(&current_neg_parity_right) {
                            // If a matching left part is found, update max_len_seg.
                            // The length of the subarray `segment[i_val..j]` is `j - i_val + 1`.
                            max_len_seg = max_len_seg.max(j - i_val + 1);
                        }
                    }
                }
            }
        }

        max_len_seg
    }
}