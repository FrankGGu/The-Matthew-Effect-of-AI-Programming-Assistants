struct Solution;

impl Solution {
    pub fn num_special(mat: Vec<Vec<i32>>) -> i32 {
        let rows = mat.len();
        let cols = mat[0].len();
        let mut row_counts = vec![0; rows];
        let mut col_counts = vec![0; cols];

        for i in 0..rows {
            for j in 0..cols {
                if mat[i][j] == 1 {
                    row_counts[i] += 1;
                    col_counts[j] += 1;
                }
            }
        }

        let mut result = 0;
        for i in 0..rows {
            for j in 0..cols {
                if mat[i][j] == 1 && row_counts[i] == 1 && col_counts[j] == 1 {
                    result += 1;
                }
            }
        }

        result
    }
}