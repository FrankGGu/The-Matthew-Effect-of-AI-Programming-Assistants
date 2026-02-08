impl Solution {
    pub fn number_of_sequences(n: i32, requirements: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut req = vec![-1; n + 1];
        for r in requirements {
            req[r[0] as usize] = r[1] as i32;
        }
        if req[0] != -1 && req[0] != 0 {
            return 0;
        }
        req[0] = 0;

        let mut dp = vec![vec![0; n + 2]; n + 2];
        dp[0][0] = 1;

        for i in 1..=n {
            for k in 0..=i {
                if req[i] != -1 && req[i] != k as i32 {
                    continue;
                }
                for prev_k in 0..=i - 1 {
                    if prev_k >= k {
                        dp[i][k] = (dp[i][k] + dp[i - 1][prev_k]) % 1_000_000_007;
                    }
                    if prev_k <= k {
                        dp[i][k] = (dp[i][k] + dp[i - 1][prev_k]) % 1_000_000_007;
                    }
                }
            }
        }

        let mut res = 0;
        for k in 0..=n {
            res = (res + dp[n][k]) % 1_000_000_007;
        }
        res
    }
}