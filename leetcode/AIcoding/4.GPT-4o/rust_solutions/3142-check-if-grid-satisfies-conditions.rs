impl Solution {
    pub fn check_valid_grid(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        let mut visited = vec![vec![false; n]; n];
        let mut curr_x = 0;
        let mut curr_y = 0;

        for i in 0..n * n {
            if visited[curr_x][curr_y] {
                return false;
            }
            visited[curr_x][curr_y] = true;

            if i == n * n - 1 {
                return true;
            }

            let next_x = grid[curr_x][curr_y] / n;
            let next_y = grid[curr_x][curr_y] % n;

            if (next_x + next_y) % 2 != (curr_x + curr_y) % 2 || next_x < 0 || next_x >= n as i32 || next_y < 0 || next_y >= n as i32 {
                return false;
            }

            curr_x = next_x as usize;
            curr_y = next_y as usize;
        }
        true
    }
}