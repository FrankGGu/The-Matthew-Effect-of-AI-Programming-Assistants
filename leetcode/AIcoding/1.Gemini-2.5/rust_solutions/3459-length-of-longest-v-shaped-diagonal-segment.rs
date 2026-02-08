impl Solution {
    pub fn longest_v_shaped_diagonal_segment(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        let mut len_diag_up_left = vec![vec![0; n]; m];
        let mut len_anti_diag_up_right = vec![vec![0; n]; m];

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    // Calculate len_diag_up_left: length of diagonal segment (r-c = constant) ending at (r,c) going up-left
                    if r > 0 && c > 0 && grid[r - 1][c - 1] == 1 {
                        len_diag_up_left[r][c] = 1 + len_diag_up_left[r - 1][c - 1];
                    } else {
                        len_diag_up_left[r][c] = 1;
                    }

                    // Calculate len_anti_diag_up_right: length of anti-diagonal segment (r+c = constant) ending at (r,c) going up-right
                    if r > 0 && c < n - 1 && grid[r - 1][c + 1] == 1 {
                        len_anti_diag_up_right[r][c] = 1 + len_anti_diag_up_right[r - 1][c + 1];
                    } else {
                        len_anti_diag_up_right[r][c] = 1;
                    }
                }
            }
        }

        let mut max_v_length = 0;

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    let k1 = len_diag_up_left[r][c]; // Number of points in the up-left arm including (r,c)
                    let k2 = len_anti_diag_up_right[r][c]; // Number of points in the up-right arm including (r,c)

                    // For a valid V-shaped segment, both arms must have at least 2 points.
                    // This means r1 < r2 and r3 < r2.
                    // If k1 = 1, then r1 = r2. If k2 = 1, then r3 = r2.
                    // So, k1 must be >= 2 and k2 must be >= 2.
                    if k1 >= 2 && k2 >= 2 {
                        // The length of an arm (r2 - r1 or r2 - r3) is (number of points - 1).
                        let current_v_length = (k1 - 1) + (k2 - 1);
                        if current_v_length > max_v_length {
                            max_v_length = current_v_length;
                        }
                    }
                }
            }
        }

        max_v_length
    }
}