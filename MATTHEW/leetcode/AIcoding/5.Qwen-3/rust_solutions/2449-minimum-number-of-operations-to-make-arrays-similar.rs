impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(mut nums: Vec<i64>, mut target: Vec<i64>) -> i64 {
        let mut count = HashMap::new();

        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        for &t in &target {
            *count.entry(t).or_insert(0) -= 1;
        }

        let mut operations = 0;

        for (&key, &val) in &count {
            if val > 0 {
                operations += val;
            }
        }

        operations
    }
}
}