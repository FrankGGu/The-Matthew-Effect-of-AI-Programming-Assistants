impl Solution {
    pub fn min_steps(n: i32) -> i32 {
        if n == 1 {
            return 0;
        }
        let mut dp = vec![0; (n + 1) as usize];
        for i in 2..=n {
            dp[i as usize] = i;
            for j in 2..=(i as f64).sqrt() as i32 {
                if i % j == 0 {
                    dp[i as usize] = dp[j as usize] + i / j;
                    break;
                }
            }
        }
        dp[n as usize]
    }
}