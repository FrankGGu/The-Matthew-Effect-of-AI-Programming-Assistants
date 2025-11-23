impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_ways(words: Vec<String>, target: String) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = words.len();
        let m = target.len();
        if m == 0 {
            return 1;
        }
        let mut freq = vec![0; 26];
        for word in &words {
            for c in word.chars() {
                freq[c as usize - 'a' as usize] += 1;
            }
        }
        let mut dp = vec![vec![0; m + 1]; n + 1];
        for i in 0..=n {
            dp[i][0] = 1;
        }
        for i in 1..=n {
            for j in 1..=m {
                dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1] * freq[i - 1]) % MOD;
            }
        }
        dp[n][m]
    }
}
}