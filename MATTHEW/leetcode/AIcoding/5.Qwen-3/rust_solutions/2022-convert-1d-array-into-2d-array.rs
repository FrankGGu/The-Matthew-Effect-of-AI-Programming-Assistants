impl Solution {

use std::vec;

impl Solution {
    pub fn convert_to_2d_array(original: Vec<i32>, m: i32, n: i32) -> Vec<Vec<i32>> {
        let m = m as usize;
        let n = n as usize;
        if original.len() != m * n {
            return vec![];
        }
        let mut result = vec![vec![0; n]; m];
        for i in 0..m {
            for j in 0..n {
                result[i][j] = original[i * n + j];
            }
        }
        result
    }
}
}