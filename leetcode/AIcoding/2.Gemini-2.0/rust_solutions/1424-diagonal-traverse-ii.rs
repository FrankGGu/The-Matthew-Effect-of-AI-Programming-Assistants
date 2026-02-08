use std::collections::HashMap;

impl Solution {
    pub fn find_diagonal_order(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut diagonals: HashMap<i32, Vec<i32>> = HashMap::new();
        for i in 0..nums.len() {
            for j in 0..nums[i].len() {
                diagonals.entry((i + j) as i32).or_insert(Vec::new()).push(nums[i][j]);
            }
        }

        let mut keys: Vec<i32> = diagonals.keys().cloned().collect();
        keys.sort();

        let mut result: Vec<i32> = Vec::new();
        for key in keys {
            if let Some(diagonal) = diagonals.get(&key) {
                for &val in diagonal.iter().rev() {
                    result.push(val);
                }
            }
        }

        result
    }
}