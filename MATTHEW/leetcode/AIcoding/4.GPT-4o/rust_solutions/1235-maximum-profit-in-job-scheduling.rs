use std::cmp::max;

pub fn job_scheduling(start_time: Vec<i32>, end_time: Vec<i32>, profit: Vec<i32>) -> i32 {
    let mut jobs: Vec<(i32, i32, i32)> = start_time.iter()
        .zip(end_time.iter())
        .zip(profit.iter())
        .map(|((s, e), p)| (*s, *e, *p))
        .collect();

    jobs.sort_by(|a, b| a.1.cmp(&b.1));

    let n = jobs.len();
    let mut dp = vec![0; n + 1];

    for i in 1..=n {
        let (start, end, prof) = jobs[i - 1];
        let mut j = i - 1;
        while j > 0 && jobs[j - 1].1 > start {
            j -= 1;
        }
        dp[i] = max(dp[i - 1], dp[j] + prof);
    }

    dp[n]
}