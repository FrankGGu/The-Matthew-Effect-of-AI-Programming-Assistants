pub fn max_alternating_sum(arr: Vec<i32>) -> i64 {
    let n = arr.len();
    let mut dp = vec![0; n + 1];

    for i in 0..n {
        dp[i + 1] = dp[i];
        if i % 2 == 0 {
            dp[i + 1] = (dp[i + 1] + arr[i] as i64).max(dp[i] + arr[i] as i64);
        } else {
            dp[i + 1] = dp[i + 1].max(dp[i] - arr[i] as i64);
        }
    }

    dp[n]
}