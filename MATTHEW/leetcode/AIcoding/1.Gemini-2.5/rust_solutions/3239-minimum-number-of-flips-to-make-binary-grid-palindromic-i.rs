impl Solution {
    pub fn min_flips_to_make_binary_grid_palindromic(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut flips = 0;

        for r in 0..rows {
            for c in 0..cols {
                let sym_r = rows - 1 - r;
                let sym_c = cols - 1 - c;

                if r < sym_r || (r == sym_r && c < sym_c) {
                    if grid[r][c] != grid[sym_r][sym_c] {
                        flips += 1;
                    }
                }
            }
        }

        flips
    }
}