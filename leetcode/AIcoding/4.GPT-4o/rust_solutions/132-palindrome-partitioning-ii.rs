pub fn min_cut(s: String) -> i32 {
    let n = s.len();
    let s = s.as_bytes();
    let mut dp = vec![0; n + 1];
    let mut is_palindrome = vec![vec![false; n]; n];

    for i in 0..=n {
        dp[i] = n - 1 - i;
    }

    for length in 1..=n {
        for start in 0..=n - length {
            let end = start + length - 1;
            if s[start] == s[end] && (length < 3 || is_palindrome[start + 1][end - 1]) {
                is_palindrome[start][end] = true;
                dp[start] = dp[start].min(dp[end + 1] + 1);
            }
        }
    }

    dp[0]
}