use std::collections::HashMap;

impl Solution {
    pub fn num_submatrix_sum_target(matrix: Vec<Vec<i32>>, target: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();

        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];
        for r in 0..m {
            for c in 0..n {
                prefix_sum[r + 1][c + 1] = matrix[r][c]
                                          + prefix_sum[r][c + 1]
                                          + prefix_sum[r + 1][c]
                                          - prefix_sum[r][c];
            }
        }

        let mut count = 0;

        for r1 in 0..m {
            for r2 in r1..m {
                let mut map: HashMap<i32, i32> = HashMap::new();
                map.insert(0, 1);
                let mut current_sum = 0;

                for c in 0..n {
                    // Calculate the sum of elements in column 'c' from row 'r1' to 'r2'
                    // This is equivalent to sum(matrix[r][c] for r in r1..r2)
                    // Using the 2D prefix sum:
                    // sum(matrix[r1..r2][c..c]) = prefix_sum[r2+1][c+1] - prefix_sum[r1][c+1] - prefix_sum[r2+1][c] + prefix_sum[r1][c]
                    let col_slice_sum = (prefix_sum[r2 + 1][c + 1] - prefix_sum[r1][c + 1]) - 
                                        (prefix_sum[r2 + 1][c] - prefix_sum[r1][c]);

                    current_sum += col_slice_sum;

                    if let Some(&val) = map.get(&(current_sum - target)) {
                        count += val;
                    }
                    *map.entry(current_sum).or_insert(0) += 1;
                }
            }
        }

        count
    }
}