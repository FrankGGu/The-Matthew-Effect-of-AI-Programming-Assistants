use std::collections::HashMap;

pub fn find_indices(nums: Vec<i32>, diff: i32) -> Vec<Vec<i32>> {
    let mut index_map = HashMap::new();
    let mut result = Vec::new();

    for (i, &num) in nums.iter().enumerate() {
        if let Some(&j) = index_map.get(&(num - diff)) {
            result.push(vec![j as i32, i as i32]);
        }
        if let Some(&j) = index_map.get(&(num + diff)) {
            result.push(vec![j as i32, i as i32]);
        }
        index_map.insert(num, i);
    }

    result
}