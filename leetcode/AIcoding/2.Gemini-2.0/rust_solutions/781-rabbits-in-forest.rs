use std::collections::HashMap;

impl Solution {
    pub fn num_rabbits(answers: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for answer in answers {
            *counts.entry(answer).or_insert(0) += 1;
        }

        let mut result = 0;
        for (answer, count) in counts {
            let group_size = answer + 1;
            let num_groups = (count + group_size - 1) / group_size;
            result += num_groups * group_size;
        }

        result
    }
}