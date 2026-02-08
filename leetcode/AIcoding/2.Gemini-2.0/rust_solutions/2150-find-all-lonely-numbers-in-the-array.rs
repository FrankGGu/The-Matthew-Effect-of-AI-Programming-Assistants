use std::collections::HashMap;

impl Solution {
    pub fn find_lonely(nums: Vec<i32>) -> Vec<i32> {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut result: Vec<i32> = Vec::new();
        for &num in &nums {
            if counts.get(&num) == Some(&1) {
                if !counts.contains_key(&(num - 1)) && !counts.contains_key(&(num + 1)) {
                    result.push(num);
                }
            }
        }

        result
    }
}