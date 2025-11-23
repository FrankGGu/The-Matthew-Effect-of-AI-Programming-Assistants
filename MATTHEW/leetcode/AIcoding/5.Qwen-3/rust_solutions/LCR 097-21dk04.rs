impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distinct_subseq(a: String) -> i32 {
        let mod_val = 1000000007;
        let mut dp = vec![0; a.len() + 1];
        dp[0] = 1;
        let mut last = HashMap::new();

        for (i, c) in a.chars().enumerate() {
            dp[i + 1] = (dp[i] * 2) % mod_val;
            if let Some(&prev) = last.get(&c) {
                dp[i + 1] = (dp[i + 1] - dp[prev] + mod_val) % mod_val;
            }
            last.insert(c, i);
        }

        dp[a.len()]
    }
}
}