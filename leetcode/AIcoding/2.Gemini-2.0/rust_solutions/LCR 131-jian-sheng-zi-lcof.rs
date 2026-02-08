impl Solution {
    pub fn minimum_rounds(tasks: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &task in &tasks {
            *counts.entry(task).or_insert(0) += 1;
        }

        let mut rounds = 0;
        for &count in counts.values() {
            if count == 1 {
                return -1;
            } else if count % 3 == 0 {
                rounds += count / 3;
            } else if count % 3 == 1 {
                rounds += (count - 4) / 3 + 2;
            } else {
                rounds += (count - 2) / 3 + 1;
            }
        }

        rounds
    }
}