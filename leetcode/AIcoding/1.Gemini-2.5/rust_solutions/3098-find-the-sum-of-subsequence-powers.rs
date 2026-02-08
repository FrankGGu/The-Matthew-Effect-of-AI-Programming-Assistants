use std::collections::BTreeSet;

impl Solution {
    const MOD: i64 = 1_000_000_007;

    // Modular exponentiation: (base^exp) % MOD
    fn power(mut base: i64, mut exp: i64) -> i64 {
        let mut res = 1;
        base %= Self::MOD;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % Self::MOD;
            }
            base = (base * base) % Self::MOD;
            exp /= 2;
        }
        res
    }

    // Calculates the number of subsequences of length `k` where all adjacent differences
    // are greater than or equal to `min_diff_threshold`.
    fn calculate_count_ge(n_arr: &[i32], k: i32, min_diff_threshold: i32) -> i64 {
        let n = n_arr.len();
        let k_usize = k as usize;

        // dp[j][i] = number of subsequences of length j ending at n_arr[i]
        //            with all adjacent differences >= min_diff_threshold
        // dp table size: (k+1) rows, n columns.
        let mut dp = vec![vec![0i64; n]; k_usize + 1];

        // Base case: subsequences of length 1. Each element itself is a subsequence.
        for i in 0..n {
            dp[1][i] = 1;
        }

        // Iterate for subsequence length from 2 to k
        for j in 2..=k_usize {
            // Compute prefix sums for dp[j-1] to optimize sum queries.
            // prefix_sum_dp_prev_len[p] = sum(dp[j-1][x]) for x from 0 to p.
            let mut prefix_sum_dp_prev_len = vec![0i64; n];

            // n_arr.len() is guaranteed to be at least 1 by problem constraints.
            prefix_sum_dp_prev_len[0] = dp[j-1][0];
            for p in 1..n {
                prefix_sum_dp_prev_len[p] = (prefix_sum_dp_prev_len[p-1] + dp[j-1][p]) % Self::MOD;
            }

            // Fill dp[j] for current length j
            for i in 0..n {
                let target = n_arr[i] - min_diff_threshold;

                // Find p_max_idx: the index of the first element in n_arr[0...i-1]
                // for which the condition `n_arr[x] <= target` is FALSE.
                // This means all elements from n_arr[0] to n_arr[p_max_idx - 1] satisfy the condition.
                let p_max_idx = n_arr[0..i].partition_point(|&x| x <= target);

                if p_max_idx > 0 {
                    // Sum up dp[j-1][0...p_max_idx-1] using prefix sum.
                    dp[j][i] = prefix_sum_dp_prev_len[p_max_idx - 1];
                }
            }
        }

        // Sum all subsequences of length k
        let mut total_count = 0i64;
        for i in 0..n {
            total_count = (total_count + dp[k_usize][i]) % Self::MOD;
        }
        total_count
    }

    pub fn sum_of_subsequence_powers(mut nums: Vec<i32>, k: i32, power: i32) -> i32 {
        nums.sort_unstable(); // Sort the input array to handle differences easily.

        let n = nums.len();

        // Collect all unique positive differences between elements.
        // Also include 0 as a possible minimum difference.
        let mut unique_diffs = BTreeSet::new();
        unique_diffs.insert(0); 
        for i in 0..n {
            for j in 0..i {
                unique_diffs.insert(nums[i] - nums[j]);
            }
        }

        let diffs_vec: Vec<i32> = unique_diffs.into_iter().collect();

        let mut total_sum_powers = 0i64;
        let mut prev_count_ge_D = 0i64; // Stores count(D_next) from the previous iteration

        // Iterate through unique differences in descending order.
        // This allows calculating `count(D) - count(D_next)` correctly.
        for &d in diffs_vec.iter().rev() {
            let current_count_ge_D = Self::calculate_count_ge(&nums, k, d);

            // The number of subsequences whose *exact* minimum difference is `d`
            // is `count(d) - count(d_next)`.
            // `prev_count_ge_D` holds `count(d_next)` from the previous iteration.
            let exact_min_diff_d_count = (current_count_ge_D - prev_count_ge_D + Self::MOD) % Self::MOD;

            let d_power = Self::power(d as i64, power as i64);
            total_sum_powers = (total_sum_powers + exact_min_diff_d_count * d_power) % Self::MOD;

            // Update prev_count_ge_D for the next iteration.
            prev_count_ge_D = current_count_ge_D;
        }

        total_sum_powers as i32
    }
}