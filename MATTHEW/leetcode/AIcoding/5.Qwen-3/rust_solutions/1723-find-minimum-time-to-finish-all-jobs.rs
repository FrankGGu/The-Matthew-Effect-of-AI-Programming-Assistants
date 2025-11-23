impl Solution {

use std::cmp::min;

struct Solution {}

impl Solution {
    pub fn minimum_time_to_finish_jobs(jobs: Vec<i32>, workers: Vec<i32>) -> i32 {
        let mut jobs = jobs;
        let mut workers = workers;
        jobs.sort_by(|a, b| b.cmp(a));
        workers.sort_by(|a, b| b.cmp(a));
        let mut result = 0;
        for i in 0..jobs.len() {
            result = max(result, jobs[i] + workers[i]);
        }
        result
    }
}
}