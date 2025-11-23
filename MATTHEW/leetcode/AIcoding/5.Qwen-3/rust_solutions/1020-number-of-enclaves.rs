impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn num_enclaves(mut grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        if rows == 0 || cols == 0 {
            return 0;
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        let mut queue = VecDeque::new();

        for i in 0..rows {
            if grid[i][0] == 1 {
                queue.push_back((i, 0));
                grid[i][0] = 0;
            }
            if grid[i][cols - 1] == 1 {
                queue.push_back((i, cols - 1));
                grid[i][cols - 1] = 0;
            }
        }

        for j in 0..cols {
            if grid[0][j] == 1 {
                queue.push_back((0, j));
                grid[0][j] = 0;
            }
            if grid[rows - 1][j] == 1 {
                queue.push_back((rows - 1, j));
                grid[rows - 1][j] = 0;
            }
        }

        while let Some((r, c)) = queue.pop_front() {
            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 && grid[nr as usize][nc as usize] == 1 {
                    grid[nr as usize][nc as usize] = 0;
                    queue.push_back((nr as usize, nc as usize));
                }
            }
        }

        let mut count = 0;
        for row in grid {
            for val in row {
                if val == 1 {
                    count += 1;
                }
            }
        }

        count
    }
}
}