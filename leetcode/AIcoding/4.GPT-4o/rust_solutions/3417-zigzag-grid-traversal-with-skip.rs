impl Solution {
    pub fn zigzag_grid_traversal_with_skip(grid: Vec<Vec<i32>>, skip: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let (rows, cols) = (grid.len(), grid[0].len());

        for d in 0..(rows + cols - 1) {
            let mut r = if d < rows { d } else { rows - 1 };
            let mut c = if d < rows { 0 } else { d - rows + 1 };

            if d % 2 == 0 {
                while r >= 0 && c < cols {
                    if grid[r][c] != skip {
                        result.push(grid[r][c]);
                    }
                    r -= 1;
                    c += 1;
                }
            } else {
                while r >= 0 && c < cols {
                    if grid[c][r] != skip {
                        result.push(grid[c][r]);
                    }
                    r -= 1;
                    c += 1;
                }
            }
        }
        result
    }
}