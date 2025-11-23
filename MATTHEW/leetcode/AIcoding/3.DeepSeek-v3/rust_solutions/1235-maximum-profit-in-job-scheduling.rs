use std::cmp;

struct Job {
    start: i32,
    end: i32,
    profit: i32,
}

impl Solution {
    pub fn job_scheduling(start_time: Vec<i32>, end_time: Vec<i32>, profit: Vec<i32>) -> i32 {
        let n = start_time.len();
        let mut jobs = Vec::with_capacity(n);
        for i in 0..n {
            jobs.push(Job {
                start: start_time[i],
                end: end_time[i],
                profit: profit[i],
            });
        }
        jobs.sort_by(|a, b| a.end.cmp(&b.end));

        let mut dp = vec![0; n];
        dp[0] = jobs[0].profit;

        for i in 1..n {
            let current_profit = jobs[i].profit;
            let l = Solution::binary_search(&jobs, i);
            if l != -1 {
                dp[i] = cmp::max(dp[i - 1], current_profit + dp[l as usize]);
            } else {
                dp[i] = cmp::max(dp[i - 1], current_profit);
            }
        }

        dp[n - 1]
    }

    fn binary_search(jobs: &Vec<Job>, index: usize) -> i32 {
        let mut left = 0;
        let mut right = index as i32 - 1;
        let mut result = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if jobs[mid as usize].end <= jobs[index].start {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        result
    }
}