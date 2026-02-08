impl Solution {
    pub fn find_all_good_strings(n: i32, s1: String, s2: String, evil: String) -> i32 {
        let n = n as usize;
        let mod_val = 1_000_000_007;
        let s1 = s1.as_bytes();
        let s2 = s2.as_bytes();
        let evil = evil.as_bytes();
        let m = evil.len();

        let mut kmp = vec![0; m + 1];
        let mut len = 0;
        for i in 1..=m {
            while len > 0 && evil[i - 1] != evil[len] {
                len = kmp[len];
            }
            if evil[i - 1] == evil[len] {
                len += 1;
            }
            kmp[i] = len;
        }

        let mut dp = vec![vec![vec![vec![0; 2]; 2]; m + 1]; n + 1];
        dp[0][0][0][0] = 1;

        for i in 0..n {
            for j in 0..=m {
                for k1 in 0..2 {
                    for k2 in 0..2 {
                        if dp[i][j][k1][k2] == 0 {
                            continue;
                        }

                        let start = if k1 == 1 { s1[i] } else { b'a' };
                        let end = if k2 == 1 { s2[i] } else { b'z' };

                        for ch in start..=end {
                            let mut new_j = j;
                            while new_j > 0 && ch != evil[new_j] {
                                new_j = kmp[new_j];
                            }
                            if ch == evil[new_j] {
                                new_j += 1;
                            }

                            let new_k1 = if k1 == 1 && ch == s1[i] { 1 } else { 0 };
                            let new_k2 = if k2 == 1 && ch == s2[i] { 1 } else { 0 };

                            if new_j < m {
                                dp[i + 1][new_j][new_k1][new_k2] =
                                    (dp[i + 1][new_j][new_k1][new_k2] + dp[i][j][k1][k2]) % mod_val;
                            }
                        }
                    }
                }
            }
        }

        let mut ans = 0;
        for j in 0..m {
            ans = (ans + dp[n][j][0][0]) % mod_val;
            ans = (ans + dp[n][j][0][1]) % mod_val;
            ans = (ans + dp[n][j][1][0]) % mod_val;
            ans = (ans + dp[n][j][1][1]) % mod_val;
        }

        ans
    }
}