impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn max_value(strings: Vec<String>) -> i32 {
        strings
            .into_iter()
            .map(|s| {
                let mut value = 0;
                for c in s.chars() {
                    match c {
                        'a'..='z' => value += 1,
                        _ => {}
                    }
                }
                value
            })
            .max()
            .unwrap_or(0)
    }
}
}