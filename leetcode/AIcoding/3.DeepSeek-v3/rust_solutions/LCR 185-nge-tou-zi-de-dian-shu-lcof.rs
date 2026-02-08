impl Solution {
    pub fn dices_probability(n: i32) -> Vec<f64> {
        let mut dp = vec![0.0; 6 * n as usize + 1];
        for i in 1..=6 {
            dp[i] = 1.0;
        }
        for i in 2..=n as usize {
            for j in (i..=6 * i).rev() {
                dp[j] = 0.0;
                for k in 1..=6 {
                    if j >= k && j - k >= i - 1 {
                        dp[j] += dp[j - k];
                    }
                }
            }
        }
        let total = 6.0_f64.powi(n);
        dp[n as usize..=6 * n as usize].iter().map(|&x| x / total).collect()
    }
}