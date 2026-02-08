struct Solution;

impl Solution {
    pub fn minimum_time_required(jobs: Vec<i32>, k: i32) -> i32 {
        let mut jobs = jobs;
        jobs.sort_unstable_by(|a, b| b.cmp(a)); // Sort jobs in descending order for better pruning

        let k = k as usize;
        let mut workers: Vec<i32> = vec![0; k];
        let mut min_max_load: i32 = i32::MAX;

        Self::dfs(0, &mut workers, &jobs, &mut min_max_load);

        min_max_load
    }

    fn dfs(job_idx: usize, workers: &mut Vec<i32>, jobs: &Vec<i32>, min_max_load: &mut i32) {
        // Pruning: If the current maximum load among workers is already greater than or equal to
        // the best solution found so far, this path cannot lead to a better solution.
        if *workers.iter().max().unwrap_or(&0) >= *min_max_load {
            return;
        }

        // Base case: All jobs have been assigned
        if job_idx == jobs.len() {
            let current_max_load = *workers.iter().max().unwrap_or(&0);
            *min_max_load = (*min_max_load).min(current_max_load);
            return;
        }

        let job_val = jobs[job_idx];
        let k = workers.len();

        for i in 0..k {
            // Pruning: If assigning this job to worker `i` would make their load
            // exceed or equal the best solution found so far, skip this worker.
            if workers[i] + job_val >= *min_max_load {
                continue;
            }

            let is_worker_idle = workers[i] == 0; // Check if worker is idle *before* assigning the job

            workers[i] += job_val; // Assign job
            Self::dfs(job_idx + 1, workers, jobs, min_max_load);
            workers[i] -= job_val; // Backtrack: Unassign job

            // Optimization for identical workers:
            // If the worker was idle before assigning the job (i.e., workers[i] was 0),
            // and we just finished exploring that path, then trying to assign this job
            // to any subsequent idle worker would lead to a symmetric state.
            // Therefore, we can break the loop and not try other idle workers for this job.
            if is_worker_idle {
                break;
            }
        }
    }
}