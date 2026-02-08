impl Solution {
    pub fn minimum_absolute_difference_in_sliding_submatrix(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        if m == 0 {
            return i32::MAX;
        }
        let n = grid[0].len();
        if n == 0 {
            return i32::MAX;
        }

        let k_usize = k as usize;

        if k_usize > m || k_usize > n {
            return i32::MAX;
        }

        let mut min_abs_diff = i32::MAX;

        for r in 0..=(m - k_usize) {
            for c in 0..=(n - k_usize) {
                let mut submatrix_elements = Vec::with_capacity(k_usize * k_usize);
                for i in 0..k_usize {
                    for j in 0..k_usize {
                        submatrix_elements.push(grid[r + i][c + j]);
                    }
                }

                submatrix_elements.sort_unstable();

                let mut min_current_submatrix_diff = i32::MAX;
                for i in 0..(submatrix_elements.len() - 1) {
                    let diff = submatrix_elements[i + 1] - submatrix_elements[i];
                    if diff < min_current_submatrix_diff {
                        min_current_submatrix_diff = diff;
                    }
                    if min_current_submatrix_diff == 0 {
                        break;
                    }
                }

                if min_current_submatrix_diff < min_abs_diff {
                    min_abs_diff = min_current_submatrix_diff;
                }
                if min_abs_diff == 0 {
                    return 0;
                }
            }
        }

        min_abs_diff
    }
}