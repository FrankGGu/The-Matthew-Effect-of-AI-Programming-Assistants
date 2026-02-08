use std::collections::HashMap;

impl Solution {
    pub fn array_rank_transform(arr: Vec<i32>) -> Vec<i32> {
        if arr.is_empty() {
            return Vec::new();
        }

        let mut sorted_arr = arr.clone();
        sorted_arr.sort_unstable();

        let mut rank_map: HashMap<i32, i32> = HashMap::new();
        let mut current_rank = 1;

        for &num in sorted_arr.iter() {
            if !rank_map.contains_key(&num) {
                rank_map.insert(num, current_rank);
                current_rank += 1;
            }
        }

        let mut result = Vec::with_capacity(arr.len());
        for &num in arr.iter() {
            result.push(*rank_map.get(&num).unwrap());
        }

        result
    }
}