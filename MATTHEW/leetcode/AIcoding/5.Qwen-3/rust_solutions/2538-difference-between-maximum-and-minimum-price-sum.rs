impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn max_min_difference(price: Vec<i32>) -> i32 {
        let n = price.len();
        let mut dp = vec![vec![0; 2]; n];
        let mut queue = VecDeque::new();

        for i in 0..n {
            if i == 0 {
                dp[i][0] = price[i];
                dp[i][1] = price[i];
            } else {
                let prev = i - 1;
                dp[i][0] = dp[prev][0].max(dp[prev][1] + price[i]);
                dp[i][1] = dp[prev][1].min(dp[prev][0] - price[i]);
            }

            queue.push_back(dp[i][0] - dp[i][1]);
            if queue.len() > 2 {
                queue.pop_front();
            }

            if queue.len() == 2 {
                return queue.back().unwrap() - queue.front().unwrap();
            }
        }

        0
    }
}
}