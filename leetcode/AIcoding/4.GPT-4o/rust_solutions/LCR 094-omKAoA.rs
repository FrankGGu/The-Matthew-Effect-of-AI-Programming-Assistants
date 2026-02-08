pub fn min_cut(s: String) -> i32 {
    let n = s.len();
    let s: Vec<char> = s.chars().collect();
    let mut dp = vec![0; n + 1];
    let mut is_palindrome = vec![vec![false; n]; n];

    for i in 0..=n {
        dp[i] = i as i32 - 1;
    }

    for length in 1..=n {
        for start in 0..=n - length {
            let end = start + length - 1;
            if s[start] == s[end] && (length <= 2 || is_palindrome[start + 1][end - 1]) {
                is_palindrome[start][end] = true;
                dp[end + 1] = dp[end + 1].min(dp[start] + 1);
            }
        }
    }

    dp[n]
}