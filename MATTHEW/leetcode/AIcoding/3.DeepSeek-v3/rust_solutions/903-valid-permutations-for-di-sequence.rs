impl Solution {
    pub fn num_perms_di_sequence(s: String) -> i32 {
        let n = s.len();
        let mut dp = vec![vec![0; n + 1]; n + 1];
        let modulo = 1_000_000_007;
        dp[0][0] = 1;
        for i in 1..=n {
            for j in 0..=i {
                if i == 0 {
                    continue;
                }
                let c = s.chars().nth(i - 1).unwrap();
                if c == 'D' {
                    for k in j..i {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % modulo;
                    }
                } else {
                    for k in 0..j {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % modulo;
                    }
                }
            }
        }
        let mut res = 0;
        for j in 0..=n {
            res = (res + dp[n][j]) % modulo;
        }
        res
    }
}