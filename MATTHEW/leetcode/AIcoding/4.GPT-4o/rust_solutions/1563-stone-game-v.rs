impl Solution {
    pub fn stone_game_v(stone_value: Vec<i32>) -> i32 {
        let n = stone_value.len();
        let mut dp = vec![0; n + 1];
        let mut prefix_sum = vec![0; n + 1];

        for i in 1..=n {
            prefix_sum[i] = prefix_sum[i - 1] + stone_value[i - 1];
        }

        for i in (1..=n).rev() {
            for j in i..=n {
                let left_sum = prefix_sum[j] - prefix_sum[i - 1];
                for k in i..j {
                    let right_sum = prefix_sum[k] - prefix_sum[i - 1];
                    if left_sum > right_sum {
                        dp[i] = dp[i].max(dp[k + 1] + right_sum);
                    } else if left_sum < right_sum {
                        dp[i] = dp[i].max(dp[k + 1] + left_sum);
                    } else {
                        dp[i] = dp[i].max(dp[k + 1] + left_sum);
                        dp[i] = dp[i].max(dp[k + 1] + right_sum);
                    }
                }
            }
        }

        dp[1]
    }
}