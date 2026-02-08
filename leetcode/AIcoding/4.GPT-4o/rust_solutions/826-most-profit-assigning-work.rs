pub fn max_profit_assignment(difficulty: Vec<i32>, profit: Vec<i32>, worker: Vec<i32>) -> i32 {
    let mut jobs: Vec<(i32, i32)> = difficulty.into_iter().zip(profit.into_iter()).collect();
    jobs.sort_by(|a, b| a.0.cmp(&b.0));

    let mut max_profit = 0;
    let mut max_profit_so_far = 0;
    let mut job_index = 0;

    for &w in worker.iter().sorted() {
        while job_index < jobs.len() && jobs[job_index].0 <= w {
            max_profit_so_far = max_profit_so_far.max(jobs[job_index].1);
            job_index += 1;
        }
        max_profit += max_profit_so_far;
    }

    max_profit
}