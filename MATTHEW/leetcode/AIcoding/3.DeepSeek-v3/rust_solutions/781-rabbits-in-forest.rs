use std::collections::HashMap;

impl Solution {
    pub fn num_rabbits(answers: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &ans in &answers {
            *count.entry(ans + 1).or_insert(0) += 1;
        }
        let mut res = 0;
        for (group_size, cnt) in count {
            res += ((cnt as f64 / group_size as f64).ceil() as i32) * group_size;
        }
        res
    }
}