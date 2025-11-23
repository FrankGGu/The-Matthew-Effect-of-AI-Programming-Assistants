impl Solution {

use std::cmp::min;

struct Solution;

impl Solution {
    pub fn min_cost(
        houses: Vec<&str>,
        cost: Vec<Vec<i32>>,
        m: i32,
        n: i32,
        k: i32,
    ) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![i32::MAX; k]; m];
        let mut dist = vec![vec![0; n]; n];

        for i in 0..n {
            for j in i+1..n {
                dist[i][j] = dist[i][j-1] + (houses[j].to_string() != houses[j-1].to_string()) as i32;
            }
        }

        for i in 0..m {
            dp[i][0] = 0;
        }

        for i in 0..m {
            for j in 1..k {
                for l in 0..i {
                    if dp[l][j-1] != i32::MAX {
                        let current_cost = dist[l][i-1];
                        dp[i][j] = min(dp[i][j], dp[l][j-1] + current_cost);
                    }
                }
            }
        }

        let result = dp[m-1][k-1];
        if result == i32::MAX {
            -1
        } else {
            result
        }
    }
}
}