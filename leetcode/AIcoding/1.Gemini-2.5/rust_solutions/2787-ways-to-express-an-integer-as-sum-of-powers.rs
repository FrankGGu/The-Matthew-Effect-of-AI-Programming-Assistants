impl Solution {
    pub fn number_of_ways(n: i32, k: i32) -> i32 {
        let n_usize = n as usize;
        let k_u32 = k as u32;
        let modulo: i32 = 1_000_000_007;

        let mut dp = vec![0; n_usize + 1];
        dp[0] = 1;

        let mut x = 1;
        loop {
            let power_val = (x as i32).pow(k_u32);
            if power_val > n {
                break;
            }

            for j in (power_val as usize..=n_usize).rev() {
                dp[j] = (dp[j] + dp[j - power_val as usize]) % modulo;
            }
            x += 1;
        }

        dp[n_usize]
    }
}