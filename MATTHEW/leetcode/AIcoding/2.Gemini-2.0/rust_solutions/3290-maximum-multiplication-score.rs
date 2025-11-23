impl Solution {
    pub fn maximum_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for i in (0..m).rev() {
            for left in (0..=i).rev() {
                let right = n - 1 - (i - left);
                dp[i][left] = multipliers[i] * nums[left] + dp[i + 1][left + 1];
                dp[i][left] = dp[i][left].max(multipliers[i] * nums[right] + dp[i + 1][left]);
            }
        }

        dp[0][0]
    }
}