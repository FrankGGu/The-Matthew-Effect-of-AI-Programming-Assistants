impl Solution {
    pub fn number_of_ways(n: i32, x: i32) -> i32 {
        let n = n as usize;
        let x = x as i32;

        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        let mut i = 1;
        while (i as f64).powi(x) <= n as f64 {
            let pow = (i as f64).powi(x) as usize;
            for j in pow..=n {
                dp[j] = (dp[j] + dp[j - pow]) % 1_000_000_007;
            }
            i += 1;
        }

        dp[n] as i32
    }
}