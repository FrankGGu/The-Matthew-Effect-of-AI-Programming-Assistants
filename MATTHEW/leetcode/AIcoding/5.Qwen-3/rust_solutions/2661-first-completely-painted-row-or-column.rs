impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn first_complete_match(arr: Vec<i32>, mat: Vec<Vec<i32>>) -> i32 {
        let mut row_counts = vec![0; mat.len()];
        let mut col_counts = vec![0; mat[0].len()];
        let mut pos_map = std::collections::HashMap::new();

        for (i, row) in mat.iter().enumerate() {
            for (j, &val) in row.iter().enumerate() {
                pos_map.insert(val, (i, j));
            }
        }

        for (idx, &num) in arr.iter().enumerate() {
            let (i, j) = pos_map.get(&num).unwrap();
            row_counts[*i] += 1;
            col_counts[*j] += 1;

            if row_counts[*i] == mat[0].len() || col_counts[*j] == mat.len() {
                return idx as i32;
            }
        }

        -1
    }
}
}