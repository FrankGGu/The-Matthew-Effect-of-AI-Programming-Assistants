impl Solution {
    pub fn stone_game_v(stone_value: Vec<i32>) -> i32 {
        let n = stone_value.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + stone_value[i];
        }

        let mut dp = vec![vec![0; n]; n];

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                for k in i..j {
                    let left_sum = prefix[k + 1] - prefix[i];
                    let right_sum = prefix[j + 1] - prefix[k + 1];
                    if left_sum < right_sum {
                        dp[i][j] = dp[i][j].max(left_sum + dp[i][k]);
                    } else if left_sum > right_sum {
                        dp[i][j] = dp[i][j].max(right_sum + dp[k + 1][j]);
                    } else {
                        dp[i][j] = dp[i][j].max(left_sum + dp[i][k].max(dp[k + 1][j]));
                    }
                }
            }
        }

        dp[0][n - 1]
    }
}