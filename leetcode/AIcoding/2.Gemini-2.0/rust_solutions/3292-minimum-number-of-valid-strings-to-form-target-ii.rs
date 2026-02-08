impl Solution {
    pub fn min_number_of_valid_strings(target: String, words: Vec<String>) -> i32 {
        let n = target.len();
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        for i in 0..=n {
            if dp[i] == i32::MAX {
                continue;
            }
            for word in &words {
                let m = word.len();
                if i + m <= n && target[i..i + m] == word[..] {
                    dp[i + m] = dp[i + m].min(dp[i] + 1);
                }
            }
        }

        if dp[n] == i32::MAX {
            -1
        } else {
            dp[n]
        }
    }
}