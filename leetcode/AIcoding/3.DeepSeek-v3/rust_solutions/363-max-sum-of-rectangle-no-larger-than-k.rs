use std::collections::BTreeSet;

impl Solution {
    pub fn max_sum_submatrix(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut max_sum = i32::MIN;

        for left in 0..cols {
            let mut row_sum = vec![0; rows];
            for right in left..cols {
                for i in 0..rows {
                    row_sum[i] += matrix[i][right];
                }

                let mut prefix_sum = 0;
                let mut bst = BTreeSet::new();
                bst.insert(0);

                for &sum in &row_sum {
                    prefix_sum += sum;
                    if let Some(&x) = bst.range(prefix_sum - k..).next() {
                        max_sum = max_sum.max(prefix_sum - x);
                    }
                    bst.insert(prefix_sum);
                }
            }
        }

        max_sum
    }
}