impl Solution {
    pub fn find_snake_order(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        if matrix.is_empty() || matrix[0].is_empty() {
            return vec![];
        }
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut result = Vec::with_capacity(rows * cols);
        for i in 0..rows {
            if i % 2 == 0 {
                for j in 0..cols {
                    result.push(matrix[i][j]);
                }
            } else {
                for j in (0..cols).rev() {
                    result.push(matrix[i][j]);
                }
            }
        }
        result
    }
}