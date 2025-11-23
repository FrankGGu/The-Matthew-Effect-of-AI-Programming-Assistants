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

        let mut low: i32 = 0;
        let mut high: i32 = (m * n - 1) as i32;

        while low <= high {
            let mid: i32 = low + (high - low) / 2;

            let mid_usize = mid as usize;
            let row = mid_usize / n;
            let col = mid_usize % n;

            let val = matrix[row][col];

            if val == target {
                return true;
            } else if val < target {
                low = mid + 1;
            } else { // val > target
                high = mid - 1;
            }
        }

        false
    }
}