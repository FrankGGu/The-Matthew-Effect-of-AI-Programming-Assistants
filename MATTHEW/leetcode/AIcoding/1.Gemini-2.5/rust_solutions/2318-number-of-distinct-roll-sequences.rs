impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn distinct_roll_sequences(n: i32) -> i32 {
        let n = n as usize;
        let modular: i64 = 1_000_000_007;

        if n == 1 {
            return 6;
        }

        let mut is_coprime = vec![vec![false; 7]; 7];
        for i in 1..=6 {
            for j in 1..=6 {
                if Self::gcd(i, j) == 1 {
                    is_coprime[i][j] = true;
                }
            }
        }

        let mut dp = vec![vec![0i64; 6]; 6];

        for last in 0..6 {
            for prev_last in 0..6 {
                if last != prev_last {
                    dp[last][prev_last] = 1;
                }
            }
        }

        for _k in 3..=n {
            let mut next_dp = vec![vec![0i64; 6]; 6];
            for last in 0..6 {
                for prev_last in 0..6 {
                    if dp[last][prev_last] == 0 {
                        continue;
                    }
                    for next_val in 0..6 {
                        if next_val == last {
                            continue;
                        }
                        if is_coprime[next_val + 1][prev_last + 1] {
                            next_dp[next_val][last] = (next_dp[next_val][last] + dp[last][prev_last]) % modular;
                        }
                    }
                }
            }
            dp = next_dp;
        }

        let mut ans: i64 = 0;
        for last in 0..6 {
            for prev_last in 0..6 {
                ans = (ans + dp[last][prev_last]) % modular;
            }
        }

        ans as i32
    }
}