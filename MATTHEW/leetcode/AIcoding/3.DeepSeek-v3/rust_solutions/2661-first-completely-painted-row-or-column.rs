use std::collections::HashMap;

impl Solution {
    pub fn first_complete_index(arr: Vec<i32>, mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut row_counts = vec![0; m];
        let mut col_counts = vec![0; n];
        let mut pos_map = HashMap::new();

        for i in 0..m {
            for j in 0..n {
                pos_map.insert(mat[i][j], (i, j));
            }
        }

        for (idx, &num) in arr.iter().enumerate() {
            if let Some(&(i, j)) = pos_map.get(&num) {
                row_counts[i] += 1;
                if row_counts[i] == n {
                    return idx as i32;
                }
                col_counts[j] += 1;
                if col_counts[j] == m {
                    return idx as i32;
                }
            }
        }

        -1
    }
}