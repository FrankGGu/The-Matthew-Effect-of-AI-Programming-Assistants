struct Solution;

impl Solution {
    pub fn check_valid_grid(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        let total_cells = n * n;

        if grid[0][0] != 0 {
            return false;
        }

        let mut coords: Vec<(usize, usize)> = vec![(0, 0); total_cells];

        for r in 0..n {
            for c in 0..n {
                let val = grid[r][c] as usize;
                coords[val] = (r, c);
            }
        }

        let dr = [-2, -2, -1, -1, 1, 1, 2, 2];
        let dc = [-1, 1, -2, 2, -2, 2, -1, 1];

        for k in 0..(total_cells - 1) {
            let (r1, c1) = coords[k];
            let (r2, c2) = coords[k + 1];

            let mut is_valid_transition = false;
            for i in 0..8 {
                let next_r = r1 as i32 + dr[i];
                let next_c = c1 as i32 + dc[i];

                if next_r == r2 as i32 && next_c == c2 as i32 {
                    is_valid_transition = true;
                    break;
                }
            }

            if !is_valid_transition {
                return false;
            }
        }

        true
    }
}