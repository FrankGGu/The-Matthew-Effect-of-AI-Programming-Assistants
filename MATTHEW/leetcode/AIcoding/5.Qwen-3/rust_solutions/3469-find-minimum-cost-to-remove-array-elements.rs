impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_cost_remove_elements(nums: Vec<i32>, cost: Vec<i32>) -> i32 {
        let mut pairs = nums.iter().zip(cost.iter()).collect::<Vec<_>>();
        pairs.sort_by(|a, b| match a.0.cmp(b.0) {
            Ordering::Equal => a.1.cmp(b.1),
            other => other,
        });

        let mut total_cost = 0;
        let mut prev_val = None;

        for (val, &c) in pairs {
            if let Some(prev) = prev_val {
                if *val == prev {
                    continue;
                }
            }
            total_cost += c;
            prev_val = Some(*val);
        }

        total_cost
    }
}
}