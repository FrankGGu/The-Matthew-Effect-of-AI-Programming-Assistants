impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn least_interval(tasks: Vec<char>, n: i32) -> i32 {
        let mut freq = HashMap::new();
        for task in tasks {
            *freq.entry(task).or_insert(0) += 1;
        }

        let mut max_freq = 0;
        for &count in freq.values() {
            max_freq = std::cmp::max(max_freq, count);
        }

        let mut num_max_freq = 0;
        for &count in freq.values() {
            if count == max_freq {
                num_max_freq += 1;
            }
        }

        (max_freq - 1) * (n + 1) + num_max_freq
    }
}
}