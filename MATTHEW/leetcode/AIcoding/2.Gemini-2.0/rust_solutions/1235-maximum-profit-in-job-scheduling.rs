use std::cmp::max;

impl Solution {
    pub fn job_scheduling(start_time: Vec<i32>, end_time: Vec<i32>, profit: Vec<i32>) -> i32 {
        let n = start_time.len();
        let mut jobs: Vec<(i32, i32, i32)> = (0..n).map(|i| (start_time[i], end_time[i], profit[i])).collect();
        jobs.sort_by_key(|&(_, end, _)| end);

        let mut dp = vec![0; n + 1];
        for i in 1..=n {
            let (start, end, profit) = jobs[i - 1];
            let prev_job_idx = match jobs[..i - 1].binary_search_by(|&(s, e, p)| e.cmp(&start)) {
                Ok(idx) => idx,
                Err(idx) => idx - 1,
            };

            let prev_profit = if prev_job_idx >= 0 {
                dp[prev_job_idx + 1]
            } else {
                0
            };

            dp[i] = max(dp[i - 1], profit + prev_profit);
        }

        dp[n]
    }
}