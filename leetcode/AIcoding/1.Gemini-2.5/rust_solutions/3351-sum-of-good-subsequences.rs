struct Solution;

impl Solution {
    pub fn sum_of_good_subsequences(nums: Vec<i32>, k: i32) -> i32 {
        let k_usize = k as usize;
        let modulo = 1_000_000_007;

        // dp[r] = (count, sum_of_lengths)
        // count: number of subsequences whose sum modulo k is r
        // sum_of_lengths: sum of lengths of these subsequences
        let mut dp: Vec<(i32, i32)> = vec![(0, 0); k_usize];

        // Initialize with the empty subsequence: sum 0, length 0, 1 way
        dp[0] = (1, 0);

        for &num_val in nums.iter() {
            // Calculate num_val modulo k. Since nums[i] >= 0, simple % is fine.
            let num_mod_k = (num_val % k) as usize;

            // Create a temporary DP state to store updates for the current number.
            // This is necessary because updates for a given 'r' might depend on 'dp[r]' itself
            // if num_mod_k is 0. Iterating in reverse order is not sufficient here.
            let mut next_dp = dp.clone(); 

            for r in 0..k_usize {
                // If there are no subsequences with sum 'r' mod k from previous step, skip.
                if dp[r].0 == 0 {
                    continue;
                }

                let count_r = dp[r].0;
                let sum_len_r = dp[r].1;

                // Calculate the new remainder if num_val is included
                let new_r = (r + num_mod_k) % k_usize;

                // When we include 'num_val':
                // We form 'count_r' new subsequences.
                // Each of these new subsequences has its length increased by 1.
                // So, the total length added is 'sum_len_r' (from previous lengths)
                // plus 'count_r' (for the added 'num_val' to each subsequence).

                next_dp[new_r].0 = (next_dp[new_r].0 + count_r) % modulo;
                next_dp[new_r].1 = (next_dp[new_r].1 + sum_len_r + count_r) % modulo;
            }
            // Update the main DP state for the next iteration
            dp = next_dp;
        }

        // The result is the sum of lengths of subsequences whose sum modulo k is 0
        dp[0].1
    }
}