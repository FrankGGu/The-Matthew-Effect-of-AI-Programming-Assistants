impl Solution {
    pub fn minimum_cost(s: String, t: String) -> i32 {
        let n = s.len();
        let m = t.len();
        let mut dp = vec![vec![0; m + 1]; n + 1];

        for i in 1..=n {
            dp[i][0] = i as i32;
        }
        for j in 1..=m {
            dp[0][j] = j as i32;
        }

        for i in 1..=n {
            for j in 1..=m {
                if s.chars().nth(i - 1) == t.chars().nth(j - 1) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = (dp[i - 1][j] + 1).min(dp[i][j - 1] + 1).min(dp[i - 1][j - 1] + 1);
                }
            }
        }

        dp[n][m]
    }
}