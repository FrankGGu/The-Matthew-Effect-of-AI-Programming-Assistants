impl Solution {
    pub fn minimum_pair_removal(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; n]; n];

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                dp[i][j] = dp[i + 1][j];
                for k in i + 1..=j {
                    if nums[i] <= nums[k] {
                        dp[i][j] = dp[i][j].max(1 + dp[i + 1][k - 1] + dp[k + 1][j]);
                    }
                }
            }
        }

        (n - dp[0][n - 1]) as i32
    }
}