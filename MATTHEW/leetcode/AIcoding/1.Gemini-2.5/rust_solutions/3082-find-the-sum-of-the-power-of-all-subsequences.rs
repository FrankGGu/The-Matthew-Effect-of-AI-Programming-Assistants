impl Solution {
    pub fn sum_of_powers(nums: Vec<i32>, k: i32) -> i32 {
        let modulo: i64 = 1_000_000_007;

        // The maximum possible sum of a subsequence.
        // nums.len() is at most 50, nums[i] is at most 50.
        // So, max_sum_possible = 50 * 50 = 2500.
        let max_sum_possible = nums.len() * 50; 

        // dp[s] will store the sum of k^s for all subsequences that sum up to s.
        // Initialize dp[0] to 1 to represent the empty subsequence (sum 0, k^0 = 1).
        // This allows us to correctly calculate contributions for single-element subsequences.
        let mut dp: Vec<i64> = vec![0; max_sum_possible + 1];
        dp[0] = 1;

        // Precompute k_powers[i] = k^i % modulo for i from 0 to 50 (max value of nums[i]).
        let k_mod = k as i64 % modulo;
        let mut k_powers: Vec<i64> = vec![0; 51]; // Max num_val is 50
        k_powers[0] = 1;
        for i in 1..=50 {
            k_powers[i] = (k_powers[i - 1] * k_mod) % modulo;
        }

        // Iterate through each number in the input array.
        for &num_val in nums.iter() {
            let num = num_val as usize; // Convert to usize for array indexing
            let k_pow_num = k_powers[num]; // k^num % modulo

            // Iterate backwards from the maximum possible sum down to the current number.
            // This ensures that when we update dp[s], dp[s - num] refers to the state
            // before considering the current `num_val`, preventing multiple uses of `num_val`
            // in a single subsequence.
            for s in (num..=max_sum_possible).rev() {
                dp[s] = (dp[s] + dp[s - num] * k_pow_num) % modulo;
            }
        }

        // Calculate the total sum of powers for all non-empty subsequences.
        // This is the sum of dp[s] for s from 1 to max_sum_possible.
        let mut total_sum: i64 = 0;
        for s in 1..=max_sum_possible {
            total_sum = (total_sum + dp[s]) % modulo;
        }

        total_sum as i32
    }
}