struct Solution;

impl Solution {
    pub fn job_scheduling(start_time: Vec<i32>, end_time: Vec<i32>, profit: Vec<i32>) -> i32 {
        let n = start_time.len();
        let mut jobs: Vec<(i32, i32, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            jobs.push((start_time[i], end_time[i], profit[i]));
        }

        jobs.sort_unstable_by_key(|job| job.0);

        let mut dp: Vec<i32> = vec![0; n + 1];

        for i in (0..n).rev() {
            let (current_s, current_e, current_p) = jobs[i];

            let profit_if_not_taken = dp[i + 1];

            let search_range = &jobs[i + 1..n];
            let next_job_idx_relative = match search_range.binary_search_by_key(&current_e, |job| job.0) {
                Ok(idx) => idx,
                Err(idx) => idx,
            };

            let absolute_next_job_idx = (i + 1) + next_job_idx_relative;

            let profit_from_next_jobs = if absolute_next_job_idx < n {
                dp[absolute_next_job_idx]
            } else {
                0
            };

            let profit_if_taken = current_p + profit_from_next_jobs;

            dp[i] = profit_if_not_taken.max(profit_if_taken);
        }

        dp[0]
    }
}