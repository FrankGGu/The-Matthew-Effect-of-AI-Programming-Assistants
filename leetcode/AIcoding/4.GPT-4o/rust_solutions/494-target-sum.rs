impl Solution {
    pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
        let sum: i32 = nums.iter().sum();
        let diff = target + sum;

        if diff < 0 || diff % 2 != 0 {
            return 0;
        }

        let subset_sum = diff / 2;
        let mut dp = vec![0; (subset_sum + 1) as usize];
        dp[0] = 1;

        for num in nums {
            for j in (num..=subset_sum).rev() {
                dp[j as usize] += dp[(j - num) as usize];
            }
        }

        dp[subset_sum as usize]
    }
}