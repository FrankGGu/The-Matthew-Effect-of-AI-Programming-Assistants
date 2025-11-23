impl Solution {
    pub fn max_profit_assigning_work(difficulty: Vec<i32>, profit: Vec<i32>, worker: Vec<i32>) -> i32 {
        let mut jobs: Vec<(i32, i32)> = difficulty.into_iter().zip(profit.into_iter()).collect();
        jobs.sort_unstable();
        let mut worker = worker;
        worker.sort_unstable();

        let mut ans = 0;
        let mut i = 0;
        let mut best = 0;

        for skill in worker {
            while i < jobs.len() && skill >= jobs[i].0 {
                best = best.max(jobs[i].1);
                i += 1;
            }
            ans += best;
        }

        ans
    }
}