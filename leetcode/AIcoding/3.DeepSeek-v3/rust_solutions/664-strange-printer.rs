impl Solution {
    pub fn strange_printer(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        if n == 0 {
            return 0;
        }
        let mut dp = vec![vec![0; n]; n];
        for i in (0..n).rev() {
            dp[i][i] = 1;
            for j in i + 1..n {
                if s[i] == s[j] {
                    dp[i][j] = dp[i][j - 1];
                } else {
                    let mut min_turns = std::i32::MAX;
                    for k in i..j {
                        min_turns = min_turns.min(dp[i][k] + dp[k + 1][j]);
                    }
                    dp[i][j] = min_turns;
                }
            }
        }
        dp[0][n - 1]
    }
}