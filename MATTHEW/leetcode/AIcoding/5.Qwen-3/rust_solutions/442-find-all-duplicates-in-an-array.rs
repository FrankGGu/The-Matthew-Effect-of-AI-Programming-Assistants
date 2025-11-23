impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_duplicates(nums: Vec<i32>) -> Vec<i32> {
        let mut seen = HashSet::new();
        let mut result = Vec::new();

        for num in nums {
            if !seen.insert(num) {
                result.push(num);
            }
        }

        result
    }
}
}