pub fn get_probabilities(n: i32) -> Vec<f64> {
    let mut dp = vec![0.0; n as usize + 1];
    dp[0] = 1.0;
    for _ in 0..n {
        let mut new_dp = vec![0.0; n as usize + 1];
        for j in 0..=n {
            for k in 1..=6 {
                if j + k <= n {
                    new_dp[j + k] += dp[j] / 6.0;
                }
            }
        }
        dp = new_dp;
    }
    dp[1..].to_vec()
}