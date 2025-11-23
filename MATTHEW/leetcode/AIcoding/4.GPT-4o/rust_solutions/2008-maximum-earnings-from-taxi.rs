pub fn max_earnings(start_time: Vec<i32>, end_time: Vec<i32>, tip: Vec<i32>) -> i64 {
    let n = start_time.len();
    let mut jobs: Vec<(i32, i32, i32)> = (0..n)
        .map(|i| (end_time[i], start_time[i], tip[i]))
        .collect();

    jobs.sort();

    let mut dp = vec![0; n + 1];
    let mut idx = 0;

    for i in 0..n {
        while idx < n && jobs[idx].0 <= jobs[i].1 {
            idx += 1;
        }
        dp[i + 1] = dp[i].max(dp[idx] + jobs[i].2 as i64);
    }

    dp[n] as i64
}