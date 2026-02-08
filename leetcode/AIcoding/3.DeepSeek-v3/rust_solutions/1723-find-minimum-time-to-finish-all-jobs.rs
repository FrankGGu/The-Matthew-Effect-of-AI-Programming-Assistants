impl Solution {
    pub fn minimum_time_required(jobs: Vec<i32>, k: i32) -> i32 {
        let n = jobs.len();
        let k = k as usize;
        let mut workers = vec![0; k];
        let mut res = i32::MAX;

        fn backtrack(
            jobs: &[i32],
            workers: &mut Vec<i32>,
            idx: usize,
            max_time: i32,
            res: &mut i32,
        ) {
            if idx == jobs.len() {
                *res = (*res).min(max_time);
                return;
            }

            for i in 0..workers.len() {
                if workers[i] + jobs[idx] >= *res {
                    continue;
                }
                workers[i] += jobs[idx];
                backtrack(jobs, workers, idx + 1, max_time.max(workers[i]), res);
                workers[i] -= jobs[idx];
                if workers[i] == 0 {
                    break;
                }
            }
        }

        backtrack(&jobs, &mut workers, 0, 0, &mut res);
        res
    }
}