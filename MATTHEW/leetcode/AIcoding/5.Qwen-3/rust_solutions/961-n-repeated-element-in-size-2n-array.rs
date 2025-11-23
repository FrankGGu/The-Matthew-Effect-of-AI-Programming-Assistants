impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn repeated_element(arr: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &arr {
            *count.entry(num).or_insert(0) += 1;
            if count[&num] == 2 {
                return num;
            }
        }
        -1
    }
}

struct Solution;
}