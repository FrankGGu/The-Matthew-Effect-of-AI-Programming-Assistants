pub fn largest_sum_of_averages(a: Vec<i32>, k: i32) -> f64 {
    let n = a.len();
    let mut dp = vec![0.0; n + 1];
    let mut sum = vec![0.0; n + 1];

    for i in 1..=n {
        sum[i] = sum[i - 1] + a[i - 1] as f64;
    }

    for i in 1..=k {
        let mut new_dp = vec![0.0; n + 1];
        for j in i..=n {
            for m in 0..j {
                let avg = (sum[j] - sum[m]) / (j - m) as f64;
                new_dp[j] = new_dp[j].max(dp[m] + avg);
            }
        }
        dp = new_dp;
    }

    dp[n]
}