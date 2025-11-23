impl Solution {
    pub fn restore_matrix(row_sum: Vec<i32>, col_sum: Vec<i32>) -> Vec<Vec<i32>> {
        let m = row_sum.len();
        let n = col_sum.len();
        let mut matrix = vec![vec![0; n]; m];
        let mut row_sum_mut = row_sum;
        let mut col_sum_mut = col_sum;

        for i in 0..m {
            for j in 0..n {
                let val = row_sum_mut[i].min(col_sum_mut[j]);
                matrix[i][j] = val;
                row_sum_mut[i] -= val;
                col_sum_mut[j] -= val;
            }
        }

        matrix
    }
}