impl Solution {
    pub fn is_toeplitz_matrix(matrix: Vec<Vec<i32>>) -> bool {
        let rows = matrix.len();
        let cols = matrix[0].len();

        for i in 0..rows - 1 {
            for j in 0..cols - 1 {
                if matrix[i][j] != matrix[i + 1][j + 1] {
                    return false;
                }
            }
        }

        true
    }
}