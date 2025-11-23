impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        if matrix.is_empty() || matrix[0].is_empty() {
            return false;
        }
        let (mut left, mut right) = (0, matrix.len() * matrix[0].len() as i32);
        while left < right {
            let mid = left + (right - left) / 2;
            let mid_value = matrix[(mid / matrix[0].len() as i32) as usize][(mid % matrix[0].len() as i32) as usize];
            if mid_value == target {
                return true;
            } else if mid_value < target {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        false
    }
}