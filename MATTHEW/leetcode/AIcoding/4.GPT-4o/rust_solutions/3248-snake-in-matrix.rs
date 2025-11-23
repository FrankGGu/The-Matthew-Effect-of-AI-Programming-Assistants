pub fn snake_in_matrix(matrix: Vec<Vec<i32>>) -> Vec<i32> {
    if matrix.is_empty() || matrix[0].is_empty() {
        return vec![];
    }
    let mut result = Vec::new();
    let rows = matrix.len();
    let cols = matrix[0].len();

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