impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_ops(nums: Vec<i32>, target: Vec<i32>) -> i32 {
        let mut diff = HashMap::new();
        for &n in &nums {
            *diff.entry(n).or_insert(0) += 1;
        }
        for &t in &target {
            *diff.entry(t).or_insert(0) -= 1;
        }
        let mut ops = 0;
        for (k, v) in diff {
            if v > 0 {
                ops += v;
            } else if v < 0 {
                ops += -v;
            }
        }
        ops
    }
}
}