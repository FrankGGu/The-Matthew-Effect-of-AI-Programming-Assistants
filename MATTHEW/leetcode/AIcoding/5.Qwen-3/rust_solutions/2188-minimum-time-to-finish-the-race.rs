impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_time_to_finish(accelerations: Vec<Vec<i32>>, blocks: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; k]; n];
        let mut time = vec![0; n];

        for i in 0..n {
            time[i] = accelerations[i][0];
            for j in 1..k {
                time[i] += accelerations[i][j];
            }
        }

        for i in 0..n {
            dp[i][0] = time[i];
        }

        for j in 1..k {
            for i in 0..n {
                let mut min_time = i32::MAX;
                for m in 0..i {
                    let mut temp = dp[m][j - 1];
                    for l in m + 1..i {
                        temp += blocks[l][m];
                    }
                    temp += time[i];
                    min_time = std::cmp::min(min_time, temp);
                }
                dp[i][j] = min_time;
            }
        }

        let mut result = i32::MAX;
        for i in 0..n {
            result = std::cmp::min(result, dp[i][k - 1]);
        }

        result
    }
}
}