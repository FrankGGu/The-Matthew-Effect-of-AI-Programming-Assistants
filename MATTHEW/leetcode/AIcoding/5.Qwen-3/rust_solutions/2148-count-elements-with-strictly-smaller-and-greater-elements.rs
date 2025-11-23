impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn count_elements(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut count = 0;
        for &num in &nums {
            if freq.contains_key(&(num - 1)) && freq.contains_key(&(num + 1)) {
                count += 1;
            }
        }

        count
    }
}
}