use std::collections::HashMap;

impl Solution {
    pub fn array_rank_transform(arr: Vec<i32>) -> Vec<i32> {
        let mut sorted_arr = arr.clone();
        sorted_arr.sort();
        sorted_arr.dedup();

        let mut rank_map: HashMap<i32, i32> = HashMap::new();
        let mut rank = 1;

        for &num in &sorted_arr {
            rank_map.insert(num, rank);
            rank += 1;
        }

        let mut result: Vec<i32> = Vec::new();
        for &num in &arr {
            result.push(*rank_map.get(&num).unwrap());
        }

        result
    }
}