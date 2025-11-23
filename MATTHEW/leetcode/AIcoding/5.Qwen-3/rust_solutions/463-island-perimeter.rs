struct Solution;

impl Solution {
    pub fn island_perimeter(grid: Vec<Vec<i32>>) -> i32 {
        let mut perimeter = 0;
        let rows = grid.len();
        let cols = grid[0].len();

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == 1 {
                    perimeter += 4;
                    if r > 0 && grid[r - 1][c] == 1 {
                        perimeter -= 1;
                    }
                    if r < rows - 1 && grid[r + 1][c] == 1 {
                        perimeter -= 1;
                    }
                    if c > 0 && grid[r][c - 1] == 1 {
                        perimeter -= 1;
                    }
                    if c < cols - 1 && grid[r][c + 1] == 1 {
                        perimeter -= 1;
                    }
                }
            }
        }

        perimeter
    }
}