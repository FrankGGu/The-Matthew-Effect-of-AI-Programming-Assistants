impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn stone_game_iii(stones: Vec<i32>) -> String {
        let n = stones.len();
        let mut dp = vec![0; n + 1];

        for i in (0..n).rev() {
            dp[i] = i32::MIN;
            for j in 1..=3 {
                if i + j <= n {
                    dp[i] = dp[i].max(dp[i + j] - stones[i + j - 1]);
                }
            }
        }

        match dp[0].cmp(&0) {
            Ordering::Greater => "Alice".to_string(),
            Ordering::Less => "Bob".to_string(),
            _ => "Tie".to_string(),
        }
    }
}
}