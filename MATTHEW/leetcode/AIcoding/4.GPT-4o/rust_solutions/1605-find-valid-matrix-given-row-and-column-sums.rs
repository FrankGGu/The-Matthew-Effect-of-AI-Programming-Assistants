impl Solution {
    pub fn restore_matrix(row_sum: Vec<i32>, col_sum: Vec<i32>) -> Vec<Vec<i32>> {
        let m = row_sum.len();
        let n = col_sum.len();
        let mut matrix = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let value = row_sum[i].min(col_sum[j]);
                matrix[i][j] = value;
                row_sum[i] -= value;
                col_sum[j] -= value;
            }
        }

        matrix
    }
}