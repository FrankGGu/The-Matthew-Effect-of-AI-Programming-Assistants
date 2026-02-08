impl Solution {
    pub fn find_peak_grid(mat: Vec<Vec<i32>>) -> Vec<i32> {
        let m = mat.len();
        let n = mat[0].len();

        let mut low = 0;
        let mut high = m - 1;

        while low <= high {
            let mid_row = low + (high - low) / 2;

            let mut max_val_in_row = -1;
            let mut max_col_in_row = 0;
            for j in 0..n {
                if mat[mid_row][j] > max_val_in_row {
                    max_val_in_row = mat[mid_row][j];
                    max_col_in_row = j;
                }
            }

            let top_neighbor_val = if mid_row > 0 {
                mat[mid_row - 1][max_col_in_row]
            } else {
                -1
            };

            let bottom_neighbor_val = if mid_row < m - 1 {
                mat[mid_row + 1][max_col_in_row]
            } else {
                -1
            };

            if max_val_in_row > top_neighbor_val && max_val_in_row > bottom_neighbor_val {
                return vec![mid_row as i32, max_col_in_row as i32];
            } else if max_val_in_row < top_neighbor_val {
                high = mid_row - 1;
            } else { // max_val_in_row < bottom_neighbor_val
                low = mid_row + 1;
            }
        }

        unreachable!()
    }
}