use std::collections::HashMap;

impl Solution {
    pub fn num_submatrix_sum_target(matrix: Vec<Vec<i32>>, target: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                prefix_sum[i][j] = matrix[i - 1][j - 1] + prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1];
            }
        }

        let mut count = 0;

        for top in 0..m {
            for bottom in top..m {
                let mut sums = HashMap::new();
                sums.insert(0, 1);
                for col in 0..n {
                    let sum = prefix_sum[bottom + 1][col + 1] - prefix_sum[top][col + 1];
                    count += sums.get(&(sum - target)).unwrap_or(&0);
                    *sums.entry(sum).or_insert(0) += 1;
                }
            }
        }

        count
    }
}