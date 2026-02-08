impl Solution {
    pub fn check_valid_grid(grid: Vec<Vec<char>>) -> bool {
        for r in 0..2 {
            for c in 0..2 {
                let mut black_count = 0;
                if grid[r][c] == 'B' {
                    black_count += 1;
                }
                if grid[r][c+1] == 'B' {
                    black_count += 1;
                }
                if grid[r+1][c] == 'B' {
                    black_count += 1;
                }
                if grid[r+1][c+1] == 'B' {
                    black_count += 1;
                }

                if black_count == 0 || black_count == 4 {
                    return true;
                }
            }
        }
        false
    }
}