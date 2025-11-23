impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        if matrix.is_empty() || matrix[0].is_empty() {
            return false;
        }
        let (mut row, mut col) = (matrix.len() - 1, 0);
        while row >= 0 && col < matrix[0].len() {
            if matrix[row][col] == target {
                return true;
            } else if matrix[row][col] < target {
                col += 1;
            } else {
                row -= 1;
            }
        }
        false
    }
}