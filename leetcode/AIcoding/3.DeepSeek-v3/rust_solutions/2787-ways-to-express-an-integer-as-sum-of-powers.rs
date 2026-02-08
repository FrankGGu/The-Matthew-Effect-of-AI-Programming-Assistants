impl Solution {
    pub fn number_of_ways(n: i32, x: i32) -> i32 {
        let mod_num = 1_000_000_007;
        let max_k = (n as f64).powf(1.0 / x as f64).floor() as i32;
        let mut dp = vec![0; (n + 1) as usize];
        dp[0] = 1;

        for k in 1..=max_k {
            let power = k.pow(x as u32);
            for i in (power..=n).rev() {
                dp[i as usize] = (dp[i as usize] + dp[(i - power) as usize]) % mod_num;
            }
        }

        dp[n as usize]
    }
}