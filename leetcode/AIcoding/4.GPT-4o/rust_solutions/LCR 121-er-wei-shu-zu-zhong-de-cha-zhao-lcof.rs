impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        if matrix.is_empty() || matrix[0].is_empty() {
            return false;
        }
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut left = 0;
        let mut right = rows * cols - 1;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mid_value = matrix[mid / cols][mid % cols];

            if mid_value == target {
                return true;
            } else if mid_value < target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        false
    }
}