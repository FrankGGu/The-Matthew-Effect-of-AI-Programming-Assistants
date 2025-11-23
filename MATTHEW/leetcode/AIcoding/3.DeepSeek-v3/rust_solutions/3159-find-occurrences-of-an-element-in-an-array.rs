use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn occurrences_of_element(nums: Vec<i32>, queries: Vec<i32>, x: i32) -> Vec<i32> {
        let mut indices = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == x {
                indices.push(i as i32);
            }
        }
        let mut result = Vec::new();
        for &query in queries.iter() {
            if query <= 0 || query as usize > indices.len() {
                result.push(-1);
            } else {
                result.push(indices[query as usize - 1]);
            }
        }
        result
    }
}