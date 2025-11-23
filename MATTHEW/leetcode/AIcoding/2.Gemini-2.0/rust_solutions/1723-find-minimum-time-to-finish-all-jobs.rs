impl Solution {
    pub fn minimum_time_required(jobs: Vec<i32>, k: i32) -> i32 {
        let mut l: i32 = *jobs.iter().max().unwrap();
        let mut r: i32 = jobs.iter().sum();
        while l < r {
            let mid = l + (r - l) / 2;
            if Self::check(&jobs, k as usize, mid) {
                r = mid;
            } else {
                l = mid + 1;
            }
        }
        l
    }

    fn check(jobs: &Vec<i32>, k: usize, target: i32) -> bool {
        let mut workers = vec![0; k];
        Self::assign(jobs, 0, &mut workers, target)
    }

    fn assign(jobs: &Vec<i32>, job_index: usize, workers: &mut Vec<i32>, target: i32) -> bool {
        if job_index == jobs.len() {
            return true;
        }
        for i in 0..workers.len() {
            if workers[i] + jobs[job_index] <= target {
                workers[i] += jobs[job_index];
                if Self::assign(jobs, job_index + 1, workers, target) {
                    return true;
                }
                workers[i] -= jobs[job_index];
            }
            if workers[i] == 0 {
                break;
            }
        }
        false
    }
}