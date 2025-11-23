impl Solution {
    pub fn first_complete_index(arr: Vec<i32>, mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut pos = std::collections::HashMap::new();
        for i in 0..m {
            for j in 0..n {
                pos.insert(mat[i][j], (i, j));
            }
        }
        let mut row_count = vec![0; m];
        let mut col_count = vec![0; n];
        for (idx, &num) in arr.iter().enumerate() {
            let (row, col) = *pos.get(&num).unwrap();
            row_count[row] += 1;
            col_count[col] += 1;
            if row_count[row] == n || col_count[col] == m {
                return idx as i32;
            }
        }
        -1
    }
}