pub fn is_valid(s: String, pattern: String) -> bool {
    let n = s.len();
    let m = pattern.len();
    let s_bytes = s.as_bytes();
    let pattern_bytes = pattern.as_bytes();

    let mut dp = vec![vec![false; m + 1]; n + 1];
    dp[0][0] = true;

    for j in 1..=m {
        if pattern_bytes[j - 1] == b'*' {
            dp[0][j] = dp[0][j - 1];
        }
    }

    for i in 1..=n {
        for j in 1..=m {
            if pattern_bytes[j - 1] == b'*' {
                dp[i][j] = dp[i][j - 1] || dp[i - 1][j];
            } else if pattern_bytes[j - 1] == s_bytes[i - 1] || pattern_bytes[j - 1] == b'?' {
                dp[i][j] = dp[i - 1][j - 1];
            }
        }
    }

    dp[n][m]
}