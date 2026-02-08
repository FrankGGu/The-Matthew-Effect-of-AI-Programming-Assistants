impl Solution {
    pub fn number_of_arrays(n: i32, k: i32) -> i32 {
        if k == 0 {
            return 0;
        }
        let n = n as usize;
        let k = k as usize;
        let mod_val: i64 = 1_000_000_007;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 0..=k {
                for x in 0..=std::cmp::min(i - 1, j) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - x]) % mod_val;
                }
            }
        }

        dp[n][k] as i32
    }
}