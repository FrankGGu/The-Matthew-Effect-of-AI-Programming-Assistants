impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_impossible_or(nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        for &num in &nums {
            set.insert(num);
        }

        let mut result = 1;
        while set.contains(&result) {
            result <<= 1;
        }
        result
    }
}
}