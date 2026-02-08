impl Solution {
    pub fn find_ball(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut result = vec![0; n];

        for j in 0..n {
            let mut col = j as i32;
            let mut row = 0;

            while row < m {
                let next_col = col + grid[row][col as usize];

                if next_col < 0 || next_col >= n as i32 || grid[row][col as usize] != grid[row][next_col as usize] {
                    col = -1;
                    break;
                }

                col = next_col;
                row += 1;
            }

            result[j] = col;
        }

        result
    }
}