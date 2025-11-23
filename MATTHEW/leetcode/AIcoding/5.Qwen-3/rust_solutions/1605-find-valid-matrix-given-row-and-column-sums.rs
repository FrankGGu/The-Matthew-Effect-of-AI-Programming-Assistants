impl Solution {

use std::vec;

struct Solution;

impl Solution {
    pub fn find_matrix(row_sum: Vec<i32>, col_sum: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = vec![vec![0; col_sum.len()]; row_sum.len()];
        for i in 0..row_sum.len() {
            for j in 0..col_sum.len() {
                result[i][j] = row_sum[i].min(col_sum[j]);
                row_sum[i] -= result[i][j];
                col_sum[j] -= result[i][j];
            }
        }
        result
    }
}
}