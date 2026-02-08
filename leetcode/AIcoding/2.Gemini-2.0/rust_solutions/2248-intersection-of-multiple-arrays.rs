use std::collections::HashMap;

impl Solution {
    pub fn intersection(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        let n = nums.len();
        for arr in &nums {
            for &num in arr {
                *counts.entry(num).or_insert(0) += 1;
            }
        }

        let mut result: Vec<i32> = Vec::new();
        for (&num, &count) in &counts {
            if count == n as i32 {
                result.push(num);
            }
        }

        result.sort();
        result
    }
}