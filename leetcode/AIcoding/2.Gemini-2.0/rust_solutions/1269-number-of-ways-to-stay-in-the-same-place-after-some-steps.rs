impl Solution {
    pub fn num_ways(steps: i32, arr_len: i32) -> i32 {
        let arr_len = arr_len.min(steps);
        let steps = steps as usize;
        let arr_len = arr_len as usize;
        let modulo = 1000000007;
        let mut dp = vec![vec![0; arr_len + 1]; steps + 1];
        dp[0][0] = 1;

        for i in 1..=steps {
            for j in 0..=arr_len {
                dp[i][j] = dp[i - 1][j];
                if j > 0 {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % modulo;
                }
                if j < arr_len - 1 {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % modulo;
                }
            }
        }

        dp[steps][0]
    }
}