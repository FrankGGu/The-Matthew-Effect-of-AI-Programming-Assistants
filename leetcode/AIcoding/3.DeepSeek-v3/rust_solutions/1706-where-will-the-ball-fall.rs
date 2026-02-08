impl Solution {
    pub fn find_ball(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut res = vec![-1; n];

        for ball in 0..n {
            let mut col = ball as i32;
            for row in 0..m {
                let dir = grid[row][col as usize];
                let next_col = col + dir;
                if next_col < 0 || next_col >= n as i32 || grid[row][next_col as usize] != dir {
                    col = -1;
                    break;
                }
                col = next_col;
            }
            res[ball] = col;
        }

        res
    }
}