impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn bag_profit(capacity: i32, weights: Vec<i32>, profits: Vec<i32>) -> i32 {
        let n = weights.len();
        let mut dp = vec![0; capacity as usize + 1];

        for i in 0..n {
            for j in (weights[i] as usize)..=capacity as usize {
                dp[j] = dp[j].max(dp[j - weights[i] as usize] + profits[i]);
            }
        }

        dp[capacity as usize]
    }
}
}