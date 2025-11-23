impl Solution {
    pub fn search_matrix(matrix: Vec<Vec<i32>>, target: i32) -> bool {
        let m = matrix.len();
        if m == 0 {
            return false;
        }
        let n = matrix[0].len();
        if n == 0 {
            return false;
        }
        let mut left = 0;
        let mut right = m * n - 1;
        while left <= right {
            let mid = left + (right - left) / 2;
            let mid_val = matrix[mid / n][mid % n];
            if mid_val == target {
                return true;
            } else if mid_val < target {
                left = mid + 1;
            } else {
                if mid == 0 {
                    break;
                }
                right = mid - 1;
            }
        }
        false
    }
}