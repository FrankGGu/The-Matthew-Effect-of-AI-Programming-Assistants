impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimum_rounds(tasks: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for task in tasks {
            *freq.entry(task).or_insert(0) += 1;
        }

        let mut rounds = 0;
        for &count in freq.values() {
            if count == 1 {
                return -1;
            }
            rounds += (count + 2) / 3;
        }
        rounds
    }
}
}