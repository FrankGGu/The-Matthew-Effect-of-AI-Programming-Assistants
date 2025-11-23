impl Solution {
    pub fn unique_paths(m: i32, n: i32) -> i32 {
        let mut dp = vec![vec![0; n as usize]; m as usize];
        for i in 0..m {
            for j in 0..n {
                if i == 0 || j == 0 {
                    dp[i as usize][j as usize] = 1;
                } else {
                    dp[i as usize][j as usize] = dp[(i - 1) as usize][j as usize] + dp[i as usize][(j - 1) as usize];
                }
            }
        }
        dp[(m - 1) as usize][(n - 1) as usize]
    }
}