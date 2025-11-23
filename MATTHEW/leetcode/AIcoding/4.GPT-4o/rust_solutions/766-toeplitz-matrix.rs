impl Solution {
    pub fn is_toeplitz_matrix(matrix: Vec<Vec<i32>>) -> bool {
        let rows = matrix.len();
        let cols = matrix[0].len();

        for i in 0..rows {
            for j in 0..cols {
                if i > 0 && j > 0 && matrix[i][j] != matrix[i - 1][j - 1] {
                    return false;
                }
            }
        }
        true
    }
}