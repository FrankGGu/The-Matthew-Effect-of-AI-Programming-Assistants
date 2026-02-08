use std::collections::HashMap;

impl Solution {
    pub fn find_diagonal_order(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut groups: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut max_key = 0;

        for i in 0..nums.len() {
            for j in 0..nums[i].len() {
                let key = i as i32 + j as i32;
                groups.entry(key).or_default().push(nums[i][j]);
                max_key = max_key.max(key);
            }
        }

        let mut result = Vec::new();
        for key in 0..=max_key {
            if let Some(group) = groups.get(&key) {
                result.extend(group.iter().rev());
            }
        }

        result
    }
}