use std::cmp::{min, max};

const INF: i32 = 1_000_000_000;

impl Solution {
    pub fn minimum_incompatibility(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k_val = k as usize;
        let subset_size = n / k_val;

        let mut sorted_nums = nums;
        sorted_nums.sort_unstable();

        let mut incompatibilities = vec![INF; 1 << n];

        for mask in 1..(1 << n) {
            if mask.count_ones() as usize != subset_size {
                continue;
            }

            let mut seen_values = [false; 17]; // nums[i] are 1 to 16
            let mut is_valid_subset = true;
            let mut min_val = 17;
            let mut max_val = 0;

            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    let val = sorted_nums[i];
                    if seen_values[val as usize] {
                        is_valid_subset = false;
                        break;
                    }
                    seen_values[val as usize] = true;
                    min_val = min(min_val, val);
                    max_val = max(max_val, val);
                }
            }

            if is_valid_subset {
                incompatibilities[mask] = max_val - min_val;
            }
        }

        let mut dp = vec![INF; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == INF {
                continue;
            }

            let first_unset_idx = ((!mask) & ((1 << n) - 1)).trailing_zeros() as usize;

            if first_unset_idx == n {
                continue;
            }

            let remaining_elements_mask = ((1 << n) - 1) ^ mask ^ (1 << first_unset_idx);

            let mut sub_mask_of_remaining = remaining_elements_mask;
            loop {
                if sub_mask_of_remaining.count_ones() as usize == subset_size - 1 {
                    let current_subset_mask = sub_mask_of_remaining | (1 << first_unset_idx);

                    if incompatibilities[current_subset_mask] != INF {
                        let new_mask = mask | current_subset_mask;
                        dp[new_mask] = min(dp[new_mask], dp[mask] + incompatibilities[current_subset_mask]);
                    }
                }

                if sub_mask_of_remaining == 0 {
                    break;
                }
                sub_mask_of_remaining = (sub_mask_of_remaining - 1) & remaining_elements_mask;
            }
        }

        let result = dp[(1 << n) - 1];
        if result == INF {
            -1
        } else {
            result
        }
    }
}