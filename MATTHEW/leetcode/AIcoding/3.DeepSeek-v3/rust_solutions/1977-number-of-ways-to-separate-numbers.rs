impl Solution {
    pub fn number_of_combinations(num: String) -> i32 {
        let s = num.as_bytes();
        let n = s.len();
        if n == 0 || s[0] == b'0' {
            return 0;
        }
        let mod_num = 1_000_000_007;
        let mut dp = vec![vec![0; n + 1]; n + 1];
        let mut lcp = vec![vec![0; n + 1]; n + 1];

        for i in (0..n).rev() {
            for j in (0..n).rev() {
                if s[i] == s[j] {
                    lcp[i][j] = 1 + if i + 1 < n && j + 1 < n { lcp[i + 1][j + 1] } else { 0 };
                }
            }
        }

        for i in 0..n {
            dp[0][i + 1] = 1;
        }

        for i in 1..n {
            if s[i] == b'0' {
                continue;
            }
            for j in 1..=n {
                if i + j > n {
                    continue;
                }
                let mut cnt = 0;
                if i >= j {
                    cnt = dp[i - j][j];
                    let k = i - j;
                    if k >= 0 && j <= n && lcp[k][i] >= j {
                        let next = i + j;
                        if next <= n && s[k + j] < s[i + j] {
                            cnt = (cnt + dp[k][j]) % mod_num;
                        }
                    } else if k >= 0 && j + 1 <= n {
                        cnt = (cnt + dp[k][j + 1]) % mod_num;
                    }
                }
                dp[i][j] = (dp[i][j - 1] + cnt) % mod_num;
            }
        }

        dp[n - 1][n] as i32
    }
}