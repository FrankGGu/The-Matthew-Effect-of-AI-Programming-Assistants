impl Solution {
    pub fn strange_printer(s: String) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for length in 2..=n {
            for i in 0..=n-length {
                let j = i + length - 1;
                dp[i][j] = dp[i][j-1] + 1;
                for k in i..j {
                    if s[k] == s[j] {
                        dp[i][j] = dp[i][j].min(dp[i][k]);
                    }
                }
            }
        }

        dp[0][n-1]
    }
}