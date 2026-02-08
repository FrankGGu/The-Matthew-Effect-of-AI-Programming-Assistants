impl Solution {
    pub fn island_perimeter(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut perimeter = 0;

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == 1 {
                    perimeter += 4;

                    // Check top neighbor
                    if r > 0 && grid[r - 1][c] == 1 {
                        perimeter -= 1;
                    }
                    // Check bottom neighbor
                    if r < rows - 1 && grid[r + 1][c] == 1 {
                        perimeter -= 1;
                    }
                    // Check left neighbor
                    if c > 0 && grid[r][c - 1] == 1 {
                        perimeter -= 1;
                    }
                    // Check right neighbor
                    if c < cols - 1 && grid[r][c + 1] == 1 {
                        perimeter -= 1;
                    }
                }
            }
        }
        perimeter
    }
}