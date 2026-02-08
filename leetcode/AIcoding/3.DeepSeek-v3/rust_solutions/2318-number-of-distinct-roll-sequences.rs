impl Solution {
    pub fn distinct_sequences(n: i32) -> i32 {
        if n == 1 {
            return 6;
        }
        let n = n as usize;
        let mod_val = 1_000_000_007;
        let mut dp = vec![vec![vec![0; 7]; 7]; n + 1];
        for a in 1..=6 {
            for b in 1..=6 {
                if a != b && gcd(a, b) == 1 {
                    dp[2][a][b] = 1;
                }
            }
        }
        for i in 3..=n {
            for a in 1..=6 {
                for b in 1..=6 {
                    if a != b && gcd(a, b) == 1 {
                        for c in 1..=6 {
                            if c != b && gcd(b, c) == 1 && c != a {
                                dp[i][b][c] = (dp[i][b][c] + dp[i - 1][a][b]) % mod_val;
                            }
                        }
                    }
                }
            }
        }
        let mut res = 0;
        for a in 1..=6 {
            for b in 1..=6 {
                res = (res + dp[n][a][b]) % mod_val;
            }
        }
        res
    }
}

fn gcd(a: usize, b: usize) -> usize {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}