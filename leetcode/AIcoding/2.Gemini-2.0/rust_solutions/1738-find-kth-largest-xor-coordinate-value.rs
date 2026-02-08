impl Solution {
    pub fn kth_largest_value(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut xor_matrix = vec![vec![0; n]; m];
        let mut values = Vec::new();

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    xor_matrix[i][j] = matrix[i][j];
                } else if i == 0 {
                    xor_matrix[i][j] = xor_matrix[i][j - 1] ^ matrix[i][j];
                } else if j == 0 {
                    xor_matrix[i][j] = xor_matrix[i - 1][j] ^ matrix[i][j];
                } else {
                    xor_matrix[i][j] = xor_matrix[i - 1][j] ^ xor_matrix[i][j - 1] ^ xor_matrix[i - 1][j - 1] ^ matrix[i][j];
                }
                values.push(xor_matrix[i][j]);
            }
        }

        values.sort_unstable_by(|a, b| b.cmp(a));
        values[k as usize - 1]
    }
}