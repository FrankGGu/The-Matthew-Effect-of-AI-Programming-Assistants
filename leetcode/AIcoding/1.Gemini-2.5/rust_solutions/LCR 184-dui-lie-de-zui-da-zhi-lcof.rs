struct Solution;

impl Solution {
    pub fn minimum_time_required(mut jobs: Vec<i32>, k: i32) -> i32 {
        jobs.sort_by(|a, b| b.cmp(a));

        let n = jobs.len();
        let k_usize = k as usize;

        let mut low = *jobs.iter().max().unwrap_or(&0);
        let mut high = jobs.iter().sum();
        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            let mut worker_loads = vec![0; k_usize];

            if Self::can_finish(&jobs, k_usize, mid, &mut worker_loads, 0) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn can_finish(
        jobs: &[i32],
        k: usize,
        max_allowed_time: i32,
        worker_loads: &mut Vec<i32>,
        job_idx: usize,
    ) -> bool {
        if job_idx == jobs.len() {
            return true;
        }

        let current_job_time = jobs[job_idx];

        for i in 0..k {
            if worker_loads[i] + current_job_time <= max_allowed_time {
                worker_loads[i] += current_job_time;

                if Self::can_finish(jobs, k, max_allowed_time, worker_loads, job_idx + 1) {
                    return true;
                }

                worker_loads[i] -= current_job_time;
            }

            if worker_loads[i] == 0 {
                break;
            }
        }

        false
    }
}