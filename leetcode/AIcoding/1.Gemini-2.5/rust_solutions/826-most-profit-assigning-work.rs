impl Solution {
    pub fn max_profit_assignment(difficulty: Vec<i32>, profit: Vec<i32>, mut worker: Vec<i32>) -> i32 {
        let n = difficulty.len();

        let mut jobs: Vec<(i32, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            jobs.push((difficulty[i], profit[i]));
        }

        jobs.sort_unstable_by_key(|job| job.0);
        worker.sort_unstable();

        let mut total_profit = 0;
        let mut max_current_profit = 0;
        let mut job_idx = 0;

        for worker_ability in worker {
            while job_idx < n && jobs[job_idx].0 <= worker_ability {
                max_current_profit = max_current_profit.max(jobs[job_idx].1);
                job_idx += 1;
            }
            total_profit += max_current_profit;
        }

        total_profit
    }
}