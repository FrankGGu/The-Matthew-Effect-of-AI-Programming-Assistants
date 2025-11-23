impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn count_of_integers(&self, num: i32) -> i32 {
        let mut dp = HashMap::new();
        dp.insert(0, 1);
        for i in 1..=num {
            let mut current = 0;
            for j in 1..=i {
                if let Some(val) = dp.get(&(i - j)) {
                    current += *val;
                }
            }
            dp.insert(i, current);
        }
        *dp.get(&num).unwrap()
    }
}
}