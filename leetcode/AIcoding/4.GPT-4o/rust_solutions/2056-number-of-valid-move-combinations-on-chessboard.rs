impl Solution {
    pub fn count_combinations(n: i32, k: i32) -> i32 {
        if k == 0 {
            return 1;
        }
        let mut dp = vec![vec![0; n as usize + 1]; n as usize + 1];
        dp[0][0] = 1;

        for i in 0..=n {
            for j in 0..=n {
                if i > 0 {
                    dp[i as usize][j as usize] += dp[(i - 1) as usize][j as usize];
                }
                if j > 0 {
                    dp[i as usize][j as usize] += dp[i as usize][(j - 1) as usize];
                }
                if i > 0 && j > 0 {
                    dp[i as usize][j as usize] += dp[(i - 1) as usize][(j - 1) as usize];
                }
            }
        }

        dp[n as usize][k as usize]
    }
}