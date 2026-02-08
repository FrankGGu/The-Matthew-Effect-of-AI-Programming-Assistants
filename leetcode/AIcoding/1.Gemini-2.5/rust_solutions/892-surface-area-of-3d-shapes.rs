impl Solution {
    pub fn surface_area(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut total_surface_area = 0;

        for i in 0..n {
            for j in 0..m {
                let h = grid[i][j];

                if h > 0 {
                    total_surface_area += 2; // Top and bottom surfaces
                    total_surface_area += 4 * h; // Initial side surfaces

                    // Subtract overlapping surfaces with neighbors

                    // Check right neighbor
                    if j + 1 < m {
                        let h_right = grid[i][j + 1];
                        total_surface_area -= 2 * std::cmp::min(h, h_right);
                    }

                    // Check down neighbor
                    if i + 1 < n {
                        let h_down = grid[i + 1][j];
                        total_surface_area -= 2 * std::cmp::min(h, h_down);
                    }
                }
            }
        }

        total_surface_area
    }
}