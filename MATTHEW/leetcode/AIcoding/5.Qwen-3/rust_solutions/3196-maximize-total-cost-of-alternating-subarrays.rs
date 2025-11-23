struct Solution;

impl Solution {
    pub fn max_total_cost(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; 2]; n];

        for i in 0..n {
            if i == 0 {
                dp[i][0] = nums[i];
                dp[i][1] = -nums[i];
            } else {
                dp[i][0] = dp[i - 1][1] + nums[i];
                dp[i][1] = dp[i - 1][0] - nums[i];
            }
        }

        *dp[n - 1].iter().max().unwrap()
    }
}