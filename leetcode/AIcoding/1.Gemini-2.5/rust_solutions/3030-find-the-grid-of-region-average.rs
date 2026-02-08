impl Solution {
    pub fn result_grid(grid: Vec<Vec<i32>>, threshold: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();

        let mut result_grid = grid.clone();

        let mut sum_of_averages = vec![vec![0; n]; m];
        let mut count_of_regions = vec![vec![0; n]; m];

        // Iterate through all possible top-left corners of 3x3 regions
        // A 3x3 region needs at least 3 rows and 3 columns.
        // So, r_start can go up to m-3 and c_start up to n-3.
        for r_start in 0..=(m as i32 - 3) {
            for c_start in 0..=(n as i32 - 3) {
                let r_start = r_start as usize;
                let c_start = c_start as usize;

                let mut is_valid_region = true;
                let mut current_region_sum = 0;

                // Check validity and calculate sum for the current 3x3 region
                'check_region: for r_offset in 0..3 {
                    for c_offset in 0..3 {
                        let r = r_start + r_offset;
                        let c = c_start + c_offset;
                        current_region_sum += grid[r][c];

                        // Check right neighbor within the 3x3 region
                        if c_offset < 2 { // If not the last column in the 3x3 region
                            if (grid[r][c] - grid[r][c + 1]).abs() > threshold {
                                is_valid_region = false;
                                break 'check_region;
                            }
                        }
                        // Check down neighbor within the 3x3 region
                        if r_offset < 2 { // If not the last row in the 3x3 region
                            if (grid[r][c] - grid[r + 1][c]).abs() > threshold {
                                is_valid_region = false;
                                break 'check_region;
                            }
                        }
                    }
                }

                if is_valid_region {
                    let region_average = current_region_sum / 9; // Integer division automatically floors

                    // Update sum_of_averages and count_of_regions for all cells in this valid 3x3 region
                    for r_offset in 0..3 {
                        for c_offset in 0..3 {
                            let r = r_start + r_offset;
                            let c = c_start + c_offset;
                            sum_of_averages[r][c] += region_average;
                            count_of_regions[r][c] += 1;
                        }
                    }
                }
            }
        }

        // Final pass to update result_grid based on accumulated averages
        for r in 0..m {
            for c in 0..n {
                if count_of_regions[r][c] > 0 {
                    result_grid[r][c] = sum_of_averages[r][c] / count_of_regions[r][c];
                }
                // If count_of_regions[r][c] is 0, it means no valid 3x3 region covered this cell.
                // In this case, the cell's value remains its original value, which is already
                // present in result_grid from the initial clone.
            }
        }

        result_grid
    }
}