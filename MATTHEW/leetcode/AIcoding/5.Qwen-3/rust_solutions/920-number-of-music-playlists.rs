impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_music_playlists(n: i32, k: i32, l: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let mut dp = vec![vec![0; l as usize + 1]; n as usize + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 0..=l {
                if j > 0 {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1] * (n - (i - 1)) % mod_val) % mod_val;
                }
                if j > k {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1] * (i - k) % mod_val) % mod_val;
                }
            }
        }

        dp[n as usize][l as usize]
    }
}
}