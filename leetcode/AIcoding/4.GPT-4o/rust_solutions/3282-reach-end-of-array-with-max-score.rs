impl Solution {
    pub fn max_score(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        for i in 0..n {
            for j in (i + 1..=n).rev() {
                dp[j] = dp[j - 1].max(dp[j] + nums[i]);
            }
        }
        dp[n]
    }
}