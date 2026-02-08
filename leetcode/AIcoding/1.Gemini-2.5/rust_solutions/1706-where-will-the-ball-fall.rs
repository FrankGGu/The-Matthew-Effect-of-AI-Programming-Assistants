impl Solution {
    pub fn find_ball(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();

        let mut result = vec![-1; n];

        for start_col in 0..n {
            let mut current_col = start_col as i32;
            let mut stuck = false;

            for row in 0..m {
                let slope = grid[row][current_col as usize];
                let next_col = current_col + slope;

                // Check for wall collision
                if next_col < 0 || next_col >= n as i32 {
                    stuck = true;
                    break;
                }

                // Check for V-shape collision (ball trying to move into an opposing slope)
                // This happens if grid[row][current_col] != grid[row][next_col]
                if grid[row][next_col as usize] != slope {
                    stuck = true;
                    break;
                }

                current_col = next_col;
            }

            if !stuck {
                result[start_col] = current_col;
            }
        }

        result
    }
}