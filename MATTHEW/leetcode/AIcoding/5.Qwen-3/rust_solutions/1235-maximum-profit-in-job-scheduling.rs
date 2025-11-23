impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeMap;

impl Solution {
    pub fn job_scheduling(jobs: Vec<Vec<i32>>, start_time: Vec<i32>, end_time: Vec<i32>, profit: Vec<i32>) -> i32 {
        let n = jobs.len();
        let mut job_list = Vec::with_capacity(n);
        for i in 0..n {
            job_list.push((start_time[i], end_time[i], profit[i]));
        }
        job_list.sort_by(|a, b| a.1.cmp(&b.1));

        let mut dp = BTreeMap::new();
        dp.insert(0, 0);

        for (start, end, profit) in job_list {
            let prev = dp.range(..start).next_back().unwrap().1;
            let current = *prev + profit;
            let last = dp.range(end..).next();
            if let Some((&key, &val)) = last {
                if current > val {
                    dp.insert(end, current);
                }
            } else {
                dp.insert(end, current);
            }
        }

        *dp.values().last().unwrap()
    }
}
}