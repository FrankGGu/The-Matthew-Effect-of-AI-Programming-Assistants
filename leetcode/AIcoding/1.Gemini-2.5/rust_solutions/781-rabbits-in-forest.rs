use std::collections::HashMap;

impl Solution {
    pub fn num_rabbits(answers: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for ans in answers {
            *counts.entry(ans).or_insert(0) += 1;
        }

        let mut total_rabbits = 0;
        for (ans, count) in counts {
            let group_size = ans + 1;
            let num_groups = (count + group_size - 1) / group_size;
            total_rabbits += num_groups * group_size;
        }

        total_rabbits
    }
}