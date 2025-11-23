impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_pairs_divisible_by_60(time: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut result = 0;

        for t in time {
            let mod_val = t % 60;
            let complement = (60 - mod_val) % 60;

            if let Some(&c) = count.get(&complement) {
                result += c;
            }

            *count.entry(mod_val).or_insert(0) += 1;
        }

        result
    }
}
}