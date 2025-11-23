impl Solution {

use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn box_deliveries(boxes: Vec<Vec<i32>>) -> i32 {
        let n = boxes.len();
        let mut ports = vec![];
        let mut weights = vec![];

        for box_info in boxes {
            ports.push(box_info[0]);
            weights.push(box_info[1]);
        }

        let mut dp = vec![0; n];
        let mut q = VecDeque::new();
        let mut last_port = 0;
        let mut min_cost = 0;

        for i in 0..n {
            let port = ports[i];
            let weight = weights[i];

            while !q.is_empty() && q.front().unwrap().0 + weight > 1000 {
                let (j, cost) = q.pop_front().unwrap();
                min_cost = cost;
                last_port = ports[j];
            }

            if i == 0 {
                dp[i] = min_cost + 1;
            } else {
                dp[i] = dp[i - 1] + 1;

                if port != last_port {
                    dp[i] = dp[i].min(min_cost + 1);
                }

                if !q.is_empty() {
                    let (j, cost) = q.front().unwrap();
                    dp[i] = dp[i].min(cost + 1);
                }
            }

            q.push_back((i, dp[i]));
        }

        dp[n - 1]
    }
}
}