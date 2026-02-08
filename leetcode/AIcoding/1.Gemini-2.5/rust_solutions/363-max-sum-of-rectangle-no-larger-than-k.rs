use std::collections::BTreeSet;
use std::cmp::max;

impl Solution {
    pub fn max_sum_submatrix(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let rows = matrix.len();
        if rows == 0 {
            return 0;
        }
        let cols = matrix[0].len();
        if cols == 0 {
            return 0;
        }

        let mut max_sum = i32::MIN;

        // Determine which dimension to iterate over for the outer loops.
        // We want the outer loops to be over the smaller dimension to optimize.
        // If rows <= cols, iterate rows for outer loops, 1D array is of size `cols`.
        // If rows > cols, iterate cols for outer loops, 1D array is of size `rows`.
        let is_row_major = rows <= cols;

        let (dim1, dim2) = if is_row_major { (rows, cols) } else { (cols, rows) };

        let mut current_1d_sums = vec![0; dim2];

        for i in 0..dim1 {
            current_1d_sums.fill(0); // Reset for each new "strip"
            for j in i..dim1 {
                // For each strip (from i to j)
                for d in 0..dim2 {
                    if is_row_major {
                        current_1d_sums[d] += matrix[j][d];
                    } else {
                        current_1d_sums[d] += matrix[d][j];
                    }
                }

                // Now current_1d_sums is our 1D array.
                // Find max subarray sum in current_1d_sums that is no larger than k.
                let mut current_rect_sum = 0;
                let mut prefix_sums = BTreeSet::new();
                prefix_sums.insert(0); // For subarrays starting from index 0

                for &val in &current_1d_sums {
                    current_rect_sum += val;

                    // We need to find `prev_sum` such that `current_rect_sum - prev_sum <= k`
                    // and `current_rect_sum - prev_sum` is maximized.
                    // This is equivalent to `prev_sum >= current_rect_sum - k`
                    // We want the smallest `prev_sum` satisfying this condition.
                    if let Some(&prev_sum) = prefix_sums.range(current_rect_sum - k..).next() {
                        max_sum = max(max_sum, current_rect_sum - prev_sum);
                    }
                    prefix_sums.insert(current_rect_sum);
                }
            }
        }

        max_sum
    }
}