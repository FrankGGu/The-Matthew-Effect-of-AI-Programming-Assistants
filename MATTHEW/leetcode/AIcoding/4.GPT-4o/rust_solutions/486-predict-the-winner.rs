impl Solution {
    pub fn predict_the_winner(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = nums[i];
        }

        for length in 2..=n {
            for i in 0..=n-length {
                let j = i + length - 1;
                dp[i][j] = nums[i] - dp[i + 1][j].max(dp[i][j - 1]);
            }
        }

        dp[0][n - 1] >= 0
    }
}