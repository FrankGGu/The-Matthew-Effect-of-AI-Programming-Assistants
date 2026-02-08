impl Solution {
    pub fn restore_matrix(row_sum: Vec<i32>, col_sum: Vec<i32>) -> Vec<Vec<i32>> {
        let mut res = vec![vec![0; col_sum.len()]; row_sum.len()];
        let mut row_sum = row_sum;
        let mut col_sum = col_sum;
        for i in 0..row_sum.len() {
            for j in 0..col_sum.len() {
                let val = std::cmp::min(row_sum[i], col_sum[j]);
                res[i][j] = val;
                row_sum[i] -= val;
                col_sum[j] -= val;
            }
        }
        res
    }
}