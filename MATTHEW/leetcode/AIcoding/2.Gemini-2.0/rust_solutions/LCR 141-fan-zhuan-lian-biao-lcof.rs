impl Solution {
    pub fn get_number_of_plans(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 1..=k {
                dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1]) % 1000000007;
            }
        }

        dp[n][k] as i32
    }
}