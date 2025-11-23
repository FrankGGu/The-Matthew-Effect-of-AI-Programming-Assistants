use std::cmp::min;

impl Solution {
    pub fn minimum_cost_good_caption(words: Vec<String>, k: i32) -> i32 {
        let n = words.len();
        let k = k as usize;
        let mut dp = vec![vec![i32::MAX; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            let word_len = words[i - 1].len();
            for j in 0..=k {
                if dp[i - 1][j] != i32::MAX {
                    // Skip the current word
                    dp[i][j] = min(dp[i][j], dp[i - 1][j] + 1);

                    // Include the current word
                    if j + word_len <= k {
                        let cost = if j == 0 { 0 } else { 1 };
                        if dp[i - 1][j] != i32::MAX {
                            dp[i][j + word_len] = min(dp[i][j + word_len], dp[i - 1][j] + cost);
                        }
                    }
                }
            }
        }

        let mut ans = i32::MAX;
        for j in 0..=k {
            ans = min(ans, dp[n][j]);
        }

        ans
    }
}