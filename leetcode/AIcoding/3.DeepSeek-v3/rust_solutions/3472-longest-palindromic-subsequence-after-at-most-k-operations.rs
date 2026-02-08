impl Solution {
    pub fn longest_palindrome_subseq(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        let mut dp = vec![vec![vec![0; k + 1]; n]; n];

        for i in (0..n).rev() {
            for j in i..n {
                for l in 0..=k {
                    if i == j {
                        dp[i][j][l] = 1;
                    } else if s[i] == s[j] {
                        if i + 1 <= j - 1 {
                            dp[i][j][l] = 2 + dp[i + 1][j - 1][l];
                        } else {
                            dp[i][j][l] = 2;
                        }
                    } else {
                        let mut res = 0;
                        if i + 1 <= j {
                            res = res.max(dp[i + 1][j][l]);
                        }
                        if i <= j - 1 {
                            res = res.max(dp[i][j - 1][l]);
                        }
                        if l > 0 {
                            if i + 1 <= j - 1 {
                                res = res.max(2 + dp[i + 1][j - 1][l - 1]);
                            } else {
                                res = res.max(2);
                            }
                        }
                        dp[i][j][l] = res;
                    }
                }
            }
        }

        dp[0][n - 1][k]
    }
}