impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        if matrix.is_empty() || matrix[0].is_empty() {
            return false;
        }

        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut low = 0;
        let mut high = rows * cols - 1;

        while low <= high {
            let mid = low + (high - low) / 2;
            let row = mid / cols;
            let col = mid % cols;

            if matrix[row][col] == target {
                return true;
            } else if matrix[row][col] < target {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        false
    }
}