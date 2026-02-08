impl Solution {
    pub fn minimum_value_sum(nums: Vec<i32>, and_values: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = and_values.len();
        let mut dp = vec![vec![std::i32::MAX; n + 1]; m + 1];
        dp[0][0] = 0;

        for i in 1..=m {
            for j in 1..=n {
                let mut current_and = nums[j - 1];
                for k in (1..=j).rev() {
                    current_and &= nums[k - 1];
                    if current_and == and_values[i - 1] {
                        if dp[i - 1][k - 1] != std::i32::MAX {
                            dp[i][j] = dp[i][j].min(dp[i - 1][k - 1] + nums[k - 1]);
                        }
                    }
                }
            }
        }

        if dp[m][n] == std::i32::MAX {
            -1
        } else {
            dp[m][n]
        }
    }
}