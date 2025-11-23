impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn sort_matrix(mut matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut heap = BinaryHeap::new();

        for i in 0..rows {
            for j in 0..cols {
                if i == 0 || j == 0 {
                    heap.push(Reverse((i, j)));
                }
            }
        }

        while let Some(Reverse((i, j))) = heap.pop() {
            let val = matrix[i][j];
            let mut k = 0;
            while i + k < rows && j + k < cols {
                if k > 0 {
                    matrix[i + k][j + k] = matrix[i + k - 1][j + k - 1];
                }
                k += 1;
            }
            matrix[i + k - 1][j + k - 1] = val;
        }

        matrix
    }
}
}