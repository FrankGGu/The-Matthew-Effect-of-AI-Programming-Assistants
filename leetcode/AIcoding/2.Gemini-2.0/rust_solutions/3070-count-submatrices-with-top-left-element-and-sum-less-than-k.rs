impl Solution {
    pub fn num_submatrices(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut count = 0;
        let mut sum_matrix = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                sum_matrix[i][j] = sum_matrix[i - 1][j] + sum_matrix[i][j - 1] - sum_matrix[i - 1][j - 1] + matrix[i - 1][j - 1];
            }
        }

        for i in 1..=m {
            for j in 1..=n {
                for row in i..=m {
                    for col in j..=n {
                        let sum = sum_matrix[row][col] - sum_matrix[i - 1][col] - sum_matrix[row][j - 1] + sum_matrix[i - 1][j - 1];
                        if sum <= k {
                            count += 1;
                        }
                    }
                }
            }
        }

        count
    }
}