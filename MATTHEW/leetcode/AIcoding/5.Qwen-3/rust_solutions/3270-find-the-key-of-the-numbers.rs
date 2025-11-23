impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn find_key(nums: Vec<i32>, k: i32) -> i32 {
        let mut map = HashMap::new();
        for &num in &nums {
            *map.entry(num).or_insert(0) += 1;
        }

        for (key, value) in map {
            if value == k {
                return key;
            }
        }

        -1
    }
}
}