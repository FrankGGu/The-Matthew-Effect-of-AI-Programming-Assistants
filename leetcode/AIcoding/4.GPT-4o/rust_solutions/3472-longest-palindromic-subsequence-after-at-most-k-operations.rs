pub fn longest_palindrome_subseq(s: String, k: i32) -> i32 {
    let n = s.len();
    let s: Vec<char> = s.chars().collect();
    let mut dp = vec![vec![0; n + 1]; n + 1];

    for i in 0..n {
        dp[i][i] = 1;
    }

    for length in 2..=n {
        for left in 0..=n - length {
            let right = left + length - 1;
            if s[left] == s[right] {
                dp[left][right] = dp[left + 1][right - 1] + 2;
            } else {
                dp[left][right] = dp[left + 1][right].max(dp[left][right - 1]);
            }
        }
    }

    let longest = dp[0][n - 1];
    longest + k
}