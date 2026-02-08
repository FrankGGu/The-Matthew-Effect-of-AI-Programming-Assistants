impl Solution {
    pub fn check_partitioning(s: String) -> bool {
        let n = s.len();
        let mut dp = vec![vec![false; n]; n];

        for i in 0..n {
            dp[i][i] = true;
        }

        for i in 0..n - 1 {
            dp[i][i + 1] = s.chars().nth(i) == s.chars().nth(i + 1);
        }

        for length in 3..=n {
            for start in 0..=n - length {
                let end = start + length - 1;
                dp[start][end] = s.chars().nth(start) == s.chars().nth(end) && dp[start + 1][end - 1];
            }
        }

        for i in 0..n - 2 {
            if dp[0][i] && dp[i + 1][n - 1] {
                return true;
            }
        }

        false
    }
}