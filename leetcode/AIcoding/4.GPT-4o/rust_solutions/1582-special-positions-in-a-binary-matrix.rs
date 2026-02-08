impl Solution {
    pub fn num_special(mat: Vec<Vec<i32>>) -> i32 {
        let rows = mat.len();
        let cols = mat[0].len();
        let mut row_sums = vec![0; rows];
        let mut col_sums = vec![0; cols];

        for i in 0..rows {
            for j in 0..cols {
                row_sums[i] += mat[i][j];
                col_sums[j] += mat[i][j];
            }
        }

        let mut count = 0;
        for i in 0..rows {
            for j in 0..cols {
                if mat[i][j] == 1 && row_sums[i] == 1 && col_sums[j] == 1 {
                    count += 1;
                }
            }
        }

        count
    }
}