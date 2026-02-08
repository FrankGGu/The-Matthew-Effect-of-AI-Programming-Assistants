impl Solution {
    pub fn min_operations(s1: String, s2: String, x: i32) -> i32 {
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();
        let mut diff_indices = Vec::new();

        for i in 0..s1_chars.len() {
            if s1_chars[i] != s2_chars[i] {
                diff_indices.push(i);
            }
        }

        if diff_indices.len() % 2 != 0 {
            return -1;
        }

        let mut dp = vec![std::i32::MAX; diff_indices.len() + 1];
        dp[0] = 0;

        for i in 1..=diff_indices.len() {
            if i % 2 == 0 {
                dp[i] = dp[i - 1];
            } else {
                if i >= 1 {
                    dp[i] = dp[i - 1] + x;
                }
                if i >= 2 {
                    let cost = (diff_indices[i - 1] - diff_indices[i - 2]) as i32;
                    dp[i] = dp[i].min(dp[i - 2] + cost);
                }
            }
        }

        dp[diff_indices.len()]
    }
}