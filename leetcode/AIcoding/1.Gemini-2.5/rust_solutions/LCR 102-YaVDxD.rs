impl Solution {
    pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
        let sum: i32 = nums.iter().sum();

        // The problem can be transformed into finding a subset P of nums
        // such that sum(P) - sum(N) = target, where N is the rest of the numbers.
        // We know sum(P) + sum(N) = sum(nums).
        // Adding these two equations: 2 * sum(P) = target + sum(nums).
        // So, sum(P) = (target + sum(nums)) / 2.
        // Let s_p = sum(P). We need to find the number of subsets that sum to s_p.

        // Conditions for a valid s_p:
        // 1. (target + sum) must be non-negative. If negative, no subset of non-negative numbers can sum to it.
        // 2. (target + sum) must be even. If odd, s_p would be fractional, which is impossible for integer sums.
        if (target + sum) % 2 != 0 || (target + sum) < 0 {
            return 0;
        }

        let s_p = (target + sum) / 2;

        // dp[i] will store the number of ways to achieve a sum of 'i'.
        // The size of dp array needs to be s_p + 1 to include sum 0 up to s_p.
        let mut dp = vec![0; (s_p + 1) as usize];
        // There is one way to achieve a sum of 0 (by choosing an empty set).
        dp[0] = 1;

        // Iterate through each number in nums.
        for num in nums {
            // For each number, iterate backwards from s_p down to num.
            // This ensures that each number is used at most once for forming sums.
            for j in (num..=s_p).rev() {
                // To achieve sum 'j', we can either:
                // 1. Not include 'num': The number of ways is dp[j] (from previous iterations/numbers).
                // 2. Include 'num': The number of ways is dp[j - num] (ways to achieve the remaining sum).
                // We add these two possibilities.
                dp[j as usize] += dp[(j - num) as usize];
            }
        }

        // The final answer is the number of ways to achieve the sum s_p.
        dp[s_p as usize]
    }
}