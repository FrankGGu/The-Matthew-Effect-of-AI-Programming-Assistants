impl Solution {
    pub fn super_egg_drop(k: i32, n: i32) -> i32 {
        let k = k as usize;
        let n = n as usize;
        let mut dp = vec![vec![0; n + 1]; k + 1];
        let mut m = 0;
        while dp[k][m] < n {
            m += 1;
            for i in 1..=k {
                dp[i][m] = dp[i][m - 1] + dp[i - 1][m - 1] + 1;
            }
        }
        m as i32
    }
}