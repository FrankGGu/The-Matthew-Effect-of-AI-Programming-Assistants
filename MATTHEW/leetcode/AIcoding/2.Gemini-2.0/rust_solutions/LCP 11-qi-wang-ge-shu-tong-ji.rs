use std::collections::HashSet;

impl Solution {
    pub fn expect_number(scores: Vec<i32>) -> i32 {
        let set: HashSet<i32> = scores.into_iter().collect();
        set.len() as i32
    }
}