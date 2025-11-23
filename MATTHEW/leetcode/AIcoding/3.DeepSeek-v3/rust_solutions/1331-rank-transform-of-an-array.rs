use std::collections::HashMap;

impl Solution {
    pub fn array_rank_transform(arr: Vec<i32>) -> Vec<i32> {
        let mut sorted = arr.clone();
        sorted.sort();
        let mut rank = 1;
        let mut map = HashMap::new();
        for &num in &sorted {
            if !map.contains_key(&num) {
                map.insert(num, rank);
                rank += 1;
            }
        }
        arr.iter().map(|&x| *map.get(&x).unwrap()).collect()
    }
}