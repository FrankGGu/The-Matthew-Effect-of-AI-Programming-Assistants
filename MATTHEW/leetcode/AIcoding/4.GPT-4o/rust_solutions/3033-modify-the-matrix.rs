impl Solution {
    pub fn modify_matrix(mat: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result = mat.clone();
        let rows = mat.len();
        let cols = mat[0].len();
        let mut zero_rows = vec![false; rows];
        let mut zero_cols = vec![false; cols];

        for i in 0..rows {
            for j in 0..cols {
                if mat[i][j] == 0 {
                    zero_rows[i] = true;
                    zero_cols[j] = true;
                }
            }
        }

        for i in 0..rows {
            for j in 0..cols {
                if zero_rows[i] || zero_cols[j] {
                    result[i][j] = 0;
                }
            }
        }

        result
    }
}