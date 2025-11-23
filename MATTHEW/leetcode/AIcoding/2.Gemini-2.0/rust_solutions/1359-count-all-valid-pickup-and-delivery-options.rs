impl Solution {
    pub fn count_orders(n: i32) -> i32 {
        let mut dp = vec![0; (n + 1) as usize];
        dp[1] = 1;
        let modulo: i64 = 1_000_000_007;

        for i in 2..=n {
            let i_usize = i as usize;
            let space = i * (2 * i - 1);
            dp[i_usize] = (dp[i_usize - 1] as i64 * space as i64 % modulo) as i32;
        }

        dp[n as usize]
    }
}