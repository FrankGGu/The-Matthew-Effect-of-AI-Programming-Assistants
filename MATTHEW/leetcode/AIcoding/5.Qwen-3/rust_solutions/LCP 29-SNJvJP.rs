impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_choir_positions(choir: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut positions = vec![];
        let mut row_map = HashMap::new();
        let mut col_map = HashMap::new();

        for (i, row) in choir.iter().enumerate() {
            for (j, &val) in row.iter().enumerate() {
                if !row_map.contains_key(&val) {
                    row_map.insert(val, i);
                }
                if !col_map.contains_key(&val) {
                    col_map.insert(val, j);
                }
            }
        }

        for (i, row) in choir.iter().enumerate() {
            let mut new_row = vec![];
            for &val in row {
                let row_pos = *row_map.get(&val).unwrap();
                let col_pos = *col_map.get(&val).unwrap();
                new_row.push((row_pos + 1) * 1000 + (col_pos + 1));
            }
            positions.push(new_row);
        }

        positions
    }
}
}