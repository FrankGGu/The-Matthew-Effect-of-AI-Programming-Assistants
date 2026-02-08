impl Solution {
    pub fn check_partitioning(s: String) -> bool {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut dp = vec![vec![false; n]; n];

        for i in 0..n {
            dp[i][i] = true;
        }

        for i in 0..n - 1 {
            if s_bytes[i] == s_bytes[i + 1] {
                dp[i][i + 1] = true;
            }
        }

        for len in 3..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s_bytes[i] == s_bytes[j] && dp[i + 1][j - 1] {
                    dp[i][j] = true;
                }
            }
        }

        for i in 0..n - 2 {
            for j in i + 1..n - 1 {
                if dp[0][i] && dp[i + 1][j] && dp[j + 1][n - 1] {
                    return true;
                }
            }
        }

        false
    }
}