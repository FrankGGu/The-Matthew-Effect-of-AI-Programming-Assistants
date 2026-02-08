impl Solution {
    pub fn stone_game_iii(stone_value: Vec<i32>) -> String {
        let n = stone_value.len();
        let mut dp = vec![0; n + 1];

        for i in (0..n).rev() {
            dp[i] = stone_value[i] - dp[i + 1];
            if i + 1 < n {
                dp[i] = dp[i].max(stone_value[i] + stone_value[i + 1] - dp[i + 2]);
            }
            if i + 2 < n {
                dp[i] = dp[i].max(stone_value[i] + stone_value[i + 1] + stone_value[i + 2] - dp[i + 3]);
            }
        }

        match dp[0] {
            0 => "Tie".to_string(),
            x if x > 0 => "Alice".to_string(),
            _ => "Bob".to_string(),
        }
    }
}