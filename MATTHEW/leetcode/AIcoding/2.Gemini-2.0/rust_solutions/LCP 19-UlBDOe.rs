impl Solution {
    pub fn minimum_moves(leaves: String) -> i32 {
        let n = leaves.len();
        let s: Vec<char> = leaves.chars().collect();
        let mut dp = vec![vec![i32::MAX; 3]; n];

        dp[0][0] = if s[0] == 'r' { 0 } else { 1 };

        for i in 1..n {
            dp[i][0] = dp[i - 1][0] + if s[i] == 'r' { 0 } else { 1 };

            dp[i][1] = std::cmp::min(dp[i - 1][0], dp[i - 1][1]) + if s[i] == 'y' { 0 } else { 1 };

            if i > 1 {
                dp[i][2] = std::cmp::min(dp[i - 1][1], dp[i - 1][2]) + if s[i] == 'r' { 0 } else { 1 };
            }
        }

        dp[n - 1][2]
    }
}