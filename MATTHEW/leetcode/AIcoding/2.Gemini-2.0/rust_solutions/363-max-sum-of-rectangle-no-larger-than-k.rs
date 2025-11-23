use std::cmp;

impl Solution {
    pub fn max_sum_submatrix(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut max_sum = i32::MIN;

        for left in 0..cols {
            let mut row_sums = vec![0; rows];
            for right in left..cols {
                for i in 0..rows {
                    row_sums[i] += matrix[i][right];
                }

                let mut current_sum = 0;
                let mut sorted_sums = std::collections::BTreeSet::new();
                sorted_sums.insert(0);

                for &sum in &row_sums {
                    current_sum += sum;
                    let target = current_sum - k;
                    if let Some(&ceil) = sorted_sums.range(target..).next() {
                        max_sum = cmp::max(max_sum, current_sum - ceil);
                    }
                    sorted_sums.insert(current_sum);
                }
            }
        }

        max_sum
    }
}