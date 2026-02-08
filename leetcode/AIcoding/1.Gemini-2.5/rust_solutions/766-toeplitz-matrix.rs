impl Solution {
    pub fn is_toeplitz_matrix(matrix: Vec<Vec<i32>>) -> bool {
        let m = matrix.len();
        let n = matrix[0].len();

        for r in 0..(m - 1) {
            for c in 0..(n - 1) {
                if matrix[r][c] != matrix[r + 1][c + 1] {
                    return false;
                }
            }
        }
        true
    }
}