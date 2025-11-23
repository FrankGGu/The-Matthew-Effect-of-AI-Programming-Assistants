pub fn minimum_score(s: String, t: String) -> i32 {
    let n = s.len();
    let m = t.len();
    let mut dp = vec![vec![0; m + 1]; n + 1];

    for i in 0..=n {
        for j in 0..=m {
            if i == 0 || j == 0 {
                dp[i][j] = 0;
            } else if s.as_bytes()[i - 1] == t.as_bytes()[j - 1] {
                dp[i][j] = dp[i - 1][j - 1] + 1;
            } else {
                dp[i][j] = dp[i - 1][j].max(dp[i][j - 1]);
            }
        }
    }

    let lcs = dp[n][m];
    (n + m - 2 * lcs) as i32
}