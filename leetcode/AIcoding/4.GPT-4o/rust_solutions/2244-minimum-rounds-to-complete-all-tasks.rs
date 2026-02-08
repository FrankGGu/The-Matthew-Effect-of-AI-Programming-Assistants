impl Solution {
    pub fn minimum_rounds(tasks: Vec<i32>) -> i32 {
        use std::collections::HashMap;
        let mut count = HashMap::new();

        for &task in &tasks {
            *count.entry(task).or_insert(0) += 1;
        }

        let mut rounds = 0;

        for &value in count.values() {
            if value == 1 {
                return -1;
            }
            rounds += (value + 2) / 3;
        }

        rounds
    }
}