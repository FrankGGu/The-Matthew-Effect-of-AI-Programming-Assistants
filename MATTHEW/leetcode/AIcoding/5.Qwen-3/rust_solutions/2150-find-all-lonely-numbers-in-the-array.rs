impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_lonely(nums: Vec<i32>) -> Vec<i32> {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for &num in &nums {
            if count.get(&num) == Some(&1) && !count.contains_key(&(num - 1)) && !count.contains_key(&(num + 1)) {
                result.push(num);
            }
        }

        result
    }
}
}