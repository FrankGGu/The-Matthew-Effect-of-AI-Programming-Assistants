impl Solution {
    pub fn check_partitioning(s: String) -> bool {
        let n = s.len();
        let s = s.as_bytes();
        let mut dp = vec![vec![false; n]; n];

        for i in (0..n).rev() {
            for j in i..n {
                if i == j {
                    dp[i][j] = true;
                } else if i + 1 == j {
                    dp[i][j] = s[i] == s[j];
                } else {
                    dp[i][j] = s[i] == s[j] && dp[i + 1][j - 1];
                }
            }
        }

        for i in 1..n {
            for j in i + 1..n {
                if dp[0][i - 1] && dp[i][j - 1] && dp[j][n - 1] {
                    return true;
                }
            }
        }

        false
    }
}