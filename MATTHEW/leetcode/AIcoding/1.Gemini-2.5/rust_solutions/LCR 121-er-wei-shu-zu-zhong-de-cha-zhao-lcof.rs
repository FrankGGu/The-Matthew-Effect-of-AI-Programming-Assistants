impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        if matrix.is_empty() || matrix[0].is_empty() {
            return false;
        }

        let m = matrix.len();
        let n = matrix[0].len();

        let mut row = 0;
        let mut col = n as i32 - 1;

        while row < m && col >= 0 {
            let current_val = matrix[row][col as usize];
            if current_val == target {
                return true;
            } else if current_val < target {
                row += 1;
            } else {
                col -= 1;
            }
        }

        false
    }
}