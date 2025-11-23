impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_positions(nums: Vec<i32>) -> Vec<i32> {
        let mut positions = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            positions.entry(num).or_insert(Vec::new()).push(i as i32);
        }
        let mut result = vec![0; nums.len()];
        for (_, indices) in positions {
            for i in 0..indices.len() {
                for j in 0..indices.len() {
                    if i != j {
                        result[indices[i] as usize] += (indices[i] - indices[j]).abs();
                    }
                }
            }
        }
        result
    }
}
}