impl Solution {

use std::collections::BTreeSet;

struct Solution;

impl Solution {
    pub fn minimum_abs_diff_queries(mut queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut nums = vec![];
        for q in &queries {
            nums.push(q[0]);
        }
        nums.sort();
        let set: BTreeSet<i32> = nums.into_iter().collect();
        let mut result = vec![];
        for q in queries {
            let target = q[0];
            let k = q[1];
            let mut min_diff = i32::MAX;
            let mut count = 0;
            for &num in &set {
                let diff = (num - target).abs();
                if diff < min_diff {
                    min_diff = diff;
                    count = 1;
                } else if diff == min_diff {
                    count += 1;
                }
            }
            result.push(count);
        }
        result
    }
}
}