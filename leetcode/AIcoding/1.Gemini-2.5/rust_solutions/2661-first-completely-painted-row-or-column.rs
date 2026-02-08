use std::collections::HashMap;

impl Solution {
    pub fn first_completely_painted_row_or_column(mat: Vec<Vec<i32>>, arr: Vec<i32>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();

        let mut num_to_coords: HashMap<i32, (usize, usize)> = HashMap::new();
        for r in 0..m {
            for c in 0..n {
                num_to_coords.insert(mat[r][c], (r, c));
            }
        }

        let mut row_counts: Vec<i32> = vec![0; m];
        let mut col_counts: Vec<i32> = vec![0; n];

        for k in 0..arr.len() {
            let num = arr[k];
            let (r, c) = *num_to_coords.get(&num).unwrap();

            row_counts[r] += 1;
            col_counts[c] += 1;

            if row_counts[r] == n as i32 {
                return k as i32;
            }
            if col_counts[c] == m as i32 {
                return k as i32;
            }
        }

        // According to the problem statement, a solution is guaranteed to exist,
        // so this line should not be reached.
        -1
    }
}