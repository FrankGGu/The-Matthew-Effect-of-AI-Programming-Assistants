impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let n = s.len();
        let s = s.as_bytes();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for length in 2..=n {
            for left in 0..n - length + 1 {
                let right = left + length - 1;
                if s[left] == s[right] {
                    let mut count = 2;
                    let mut l = left + 1;
                    let mut r = right - 1;
                    while l <= r {
                        if s[l] == s[left] && s[r] == s[right] {
                            count += 1;
                            l += 1; 
                            r -= 1;
                        } else if s[l] != s[left] {
                            l += 1;
                        } else {
                            r -= 1;
                        }
                    }
                    dp[left][right] = dp[left + 1][right - 1] + count;
                } else {
                    dp[left][right] = dp[left + 1][right] + dp[left][right - 1] - dp[left + 1][right - 1];
                }
            }
        }

        dp[0][n - 1]
    }
}