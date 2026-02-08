impl Solution {
    pub fn check_record(n: i32) -> i32 {
        let n = n as usize;
        let modulo: i64 = 1_000_000_007;
        let mut dp = vec![vec![vec![0; 2]; 3]; n + 1];

        dp[0][0][0] = 1;

        for i in 1..=n {
            for j in 0..3 {
                for k in 0..2 {
                    // Present
                    dp[i][0][k] = (dp[i][0][k] + dp[i - 1][j][k]) % modulo;

                    // Absent
                    if j < 2 {
                        dp[i][j + 1][k] = (dp[i][j + 1][k] + dp[i - 1][j][k]) % modulo;
                    }

                    // Late
                    if k < 1 {
                        dp[i][0][k + 1] = (dp[i][0][k + 1] + dp[i - 1][j][k]) % modulo;
                    }
                }
            }
        }

        let mut ans: i64 = 0;
        for j in 0..3 {
            for k in 0..2 {
                ans = (ans + dp[n][j][k]) % modulo;
            }
        }

        ans as i32
    }
}