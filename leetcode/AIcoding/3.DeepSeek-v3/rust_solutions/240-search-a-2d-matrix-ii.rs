impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        if matrix.is_empty() || matrix[0].is_empty() {
            return false;
        }
        let (mut row, mut col) = (0, matrix[0].len() - 1);
        while row < matrix.len() && col < matrix[0].len() {
            match matrix[row][col].cmp(&target) {
                std::cmp::Ordering::Equal => return true,
                std::cmp::Ordering::Less => row += 1,
                std::cmp::Ordering::Greater => {
                    if col == 0 {
                        return false;
                    }
                    col -= 1;
                }
            }
        }
        false
    }
}