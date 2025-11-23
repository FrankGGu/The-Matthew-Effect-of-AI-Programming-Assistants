impl Solution {

use std::cmp::min;

impl Solution {
    pub fn min_difficulty(job_difficulties: Vec<i32>, d: i32) -> i32 {
        let n = job_difficulties.len();
        let d = d as usize;
        if n < d {
            return -1;
        }

        let mut dp = vec![vec![0; n]; d];

        for i in 0..n {
            dp[0][i] = *job_difficulties.iter().take(i + 1).max().unwrap();
        }

        for i in 1..d {
            for j in (i - 1)..n {
                let mut max_diff = 0;
                let mut min_val = i32::MAX;
                for k in (i - 1)..j {
                    max_diff = max(max_diff, job_difficulties[k]);
                    min_val = min(min_val, dp[i - 1][k] + max_diff);
                }
                dp[i][j] = min_val;
            }
        }

        dp[d - 1][n - 1]
    }
}
}