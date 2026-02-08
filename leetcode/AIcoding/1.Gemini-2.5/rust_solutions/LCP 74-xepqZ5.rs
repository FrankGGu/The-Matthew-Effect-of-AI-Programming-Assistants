struct Job {
    start: i32,
    end: i32,
    profit: i32,
}

impl Job {
    fn new(start: i32, end: i32, profit: i32) -> Self {
        Job { start, end, profit }
    }
}

impl Solution {
    pub fn job_scheduling(start_time: Vec<i32>, end_time: Vec<i32>, profit: Vec<i32>) -> i32 {
        let n = start_time.len();
        let mut jobs: Vec<Job> = Vec::with_capacity(n);
        for i in 0..n {
            jobs.push(Job::new(start_time[i], end_time[i], profit[i]));
        }

        jobs.sort_unstable_by_key(|j| j.end);

        let mut dp: Vec<(i32, i32)> = vec![(0, 0)];

        for job in jobs {
            let prev_idx = dp.partition_point(|&(end_t, _)| end_t > job.start) - 1;

            let profit_if_taken = job.profit + dp[prev_idx].1;

            let current_max_profit = dp.last().unwrap().1;

            if profit_if_taken > current_max_profit {
                dp.push((job.end, profit_if_taken));
            }
        }

        dp.last().unwrap().1
    }
}