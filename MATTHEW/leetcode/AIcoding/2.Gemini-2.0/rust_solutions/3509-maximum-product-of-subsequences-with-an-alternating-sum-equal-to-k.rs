impl Solution {
    pub fn max_product_subsequences(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut dp = vec![vec![std::i64::MIN; k as usize + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 0..=k as usize {
                dp[i][j] = dp[i][j].max(dp[i - 1][j]);
                let num = nums[i - 1];

                if num > 0 && j as i32 >= num {
                    dp[i][j] = dp[i][j].max(dp[i - 1][(j as i32 - num) as usize] * num as i64);
                } else if num < 0 {
                    for l in 0..=k as usize {
                        if (l as i32 - num) <= k {
                           dp[i][(l as i32 - num) as usize] = dp[i][(l as i32 - num) as usize].max(dp[i - 1][l] * 1);
                        }
                    }

                }
            }
        }

        if dp[n][k as usize] == std::i64::MIN {
            return -1;
        }
        dp[n][k as usize]
    }
}