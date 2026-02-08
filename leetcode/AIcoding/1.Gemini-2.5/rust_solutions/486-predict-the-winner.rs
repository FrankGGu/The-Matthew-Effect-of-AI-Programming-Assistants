impl Solution {
    pub fn predict_the_winner(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n == 0 {
            return true;
        }

        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = nums[i];
        }

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                let score_if_take_i = nums[i] - dp[i + 1][j];
                let score_if_take_j = nums[j] - dp[i][j - 1];
                dp[i][j] = score_if_take_i.max(score_if_take_j);
            }
        }

        dp[0][n - 1] >= 0
    }
}