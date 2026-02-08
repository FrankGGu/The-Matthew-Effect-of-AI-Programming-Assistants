use std::collections::HashMap;

impl Solution {
    pub fn max_equal_rows_after_flips(matrix: Vec<Vec<i32>>) -> i32 {
        let mut map = HashMap::new();
        for row in matrix {
            let key1: Vec<u8> = row.iter().map(|&x| x as u8).collect();
            let key2: Vec<u8> = row.iter().map(|&x| (1 - x) as u8).collect();
            *map.entry(key1).or_insert(0) += 1;
            *map.entry(key2).or_insert(0) += 1;
        }
        *map.values().max().unwrap_or(&0)
    }
}