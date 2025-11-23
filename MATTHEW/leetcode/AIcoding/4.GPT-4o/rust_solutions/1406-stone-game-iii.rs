impl Solution {
    pub fn stone_game_iii(stones: Vec<i32>) -> String {
        let n = stones.len();
        let mut dp = vec![std::i32::MIN; n + 1];
        dp[n] = 0;

        for i in (0..n).rev() {
            let mut sum = 0;
            for j in 1..=3 {
                if i + j <= n {
                    sum += stones[i + j - 1];
                    dp[i] = dp[i].max(sum - dp[i + j]);
                }
            }
        }

        if dp[0] > 0 {
            "Alice".to_string()
        } else if dp[0] < 0 {
            "Bob".to_string()
        } else {
            "Tie".to_string()
        }
    }
}