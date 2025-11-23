impl Solution {
    pub fn combination_sum4(nums: Vec<i32>, target: i32) -> i32 {
        let mut dp = vec![0; (target + 1) as usize];
        dp[0] = 1;

        for i in 1..=target {
            for &num in &nums {
                if i >= num {
                    dp[i as usize] += dp[(i - num) as usize];
                }
            }
        }

        dp[target as usize]
    }
}