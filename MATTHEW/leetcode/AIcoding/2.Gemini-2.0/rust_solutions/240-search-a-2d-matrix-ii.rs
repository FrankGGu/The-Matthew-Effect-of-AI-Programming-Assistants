impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        if matrix.is_empty() || matrix[0].is_empty() {
            return false;
        }

        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut row = 0;
        let mut col = cols - 1;

        while row < rows && col >= 0 {
            if matrix[row][col] == target {
                return true;
            } else if matrix[row][col] < target {
                row += 1;
            } else {
                col -= 1;
            }
        }

        false
    }
}