impl Solution {
    pub fn max_sum_div_three(nums: Vec<i32>) -> i32 {
        let mut dp = vec![0; 3];
        for &num in &nums {
            let mut new_dp = dp.clone();
            for i in 0..3 {
                new_dp[(i + num % 3 + 3) % 3] = new_dp[(i + num % 3 + 3) % 3].max(dp[i] + num);
            }
            dp = new_dp;
        }
        dp[0]
    }
}