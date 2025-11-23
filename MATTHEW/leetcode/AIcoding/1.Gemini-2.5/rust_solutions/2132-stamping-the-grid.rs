impl Solution {
    pub fn possible_to_stamp(grid: Vec<Vec<i32>>, stamp_height: i32, stamp_width: i32) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        let sh = stamp_height as usize;
        let sw = stamp_width as usize;

        // Early exit: if stamp is larger than the grid, it can only be possible if there are no '0's.
        if sh > m || sw > n {
            for r in 0..m {
                for c in 0..n {
                    if grid[r][c] == 0 {
                        return false;
                    }
                }
            }
            return true;
        }

        // Step 1: Precompute 2D prefix sums for the original grid (counting 1s)
        // ones_prefix_sum[r][c] stores the count of 1s in the rectangle (0,0) to (r-1,c-1)
        let mut ones_prefix_sum = vec![vec![0; n + 1]; m + 1];
        for r in 0..m {
            for c in 0..n {
                ones_prefix_sum[r + 1][c + 1] = grid[r][c]
                    + ones_prefix_sum[r][c + 1]
                    + ones_prefix_sum[r + 1][c]
                    - ones_prefix_sum[r][c];
            }
        }

        // Helper function to get sum of 1s in a rectangle (r1, c1) to (r2, c2) inclusive
        let get_ones_sum = |r1: usize, c1: usize, r2: usize, c2: usize| -> i32 {
            ones_prefix_sum[r2 + 1][c2 + 1]
                - ones_prefix_sum[r1][c2 + 1]
                - ones_prefix_sum[r2 + 1][c1]
                + ones_prefix_sum[r1][c1]
        };

        // Step 2: Determine where stamps can be placed
        // can_place[r][c] is true if a stamp can be placed with its top-left corner at (r,c)
        let mut can_place = vec![vec![false; n]; m];

        for r in 0..=(m - sh) {
            for c in 0..=(n - sw) {
                // A stamp can be placed if the area it covers contains no 1s
                if get_ones_sum(r, c, r + sh - 1, c + sw - 1) == 0 {
                    can_place[r][c] = true;
                }
            }
        }

        // Step 3: Use a 2D difference array to count how many stamps cover each cell
        // diff[r][c] stores the change in coverage at (r,c)
        // This array is (m+1)x(n+1) to simplify boundary conditions for updates.
        let mut diff = vec![vec![0; n + 1]; m + 1];
        for r in 0..m {
            for c in 0..n {
                if can_place[r][c] {
                    diff[r][c] += 1;
                    diff[r][c + sw] -= 1;
                    diff[r + sh][c] -= 1;
                    diff[r + sh][c + sw] += 1;
                }
            }
        }

        // Step 4: Compute the actual coverage count for each cell from the difference array
        // coverage_count[r][c] stores the total number of stamps covering cell (r,c)
        let mut coverage_count = vec![vec![0; n]; m];
        for r in 0..m {
            for c in 0..n {
                coverage_count[r][c] = diff[r][c];
                if r > 0 {
                    coverage_count[r][c] += coverage_count[r - 1][c];
                }
                if c > 0 {
                    coverage_count[r][c] += coverage_count[r][c - 1];
                }
                if r > 0 && c > 0 {
                    coverage_count[r][c] -= coverage_count[r - 1][c - 1];
                }
            }
        }

        // Step 5: Final check
        // Every cell that is 0 in the original grid must be covered by at least one stamp
        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 0 && coverage_count[r][c] == 0 {
                    return false;
                }
            }
        }

        true
    }
}