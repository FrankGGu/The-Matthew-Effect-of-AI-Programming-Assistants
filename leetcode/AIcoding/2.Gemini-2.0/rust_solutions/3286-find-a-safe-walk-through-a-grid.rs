use std::collections::VecDeque;

impl Solution {
    pub fn find_safe_walk(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut distances = vec![vec![-1; n]; m];
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    distances[i][j] = 0;
                    queue.push_back((i, j));
                }
            }
        }

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((row, col)) = queue.pop_front() {
            for &(dr, dc) in &directions {
                let new_row = row as i32 + dr;
                let new_col = col as i32 + dc;

                if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                    let new_row = new_row as usize;
                    let new_col = new_col as usize;

                    if distances[new_row][new_col] == -1 {
                        distances[new_row][new_col] = distances[row][col] + 1;
                        queue.push_back((new_row, new_col));
                    }
                }
            }
        }

        let mut max_distance = -1;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 {
                    max_distance = max_distance.max(distances[i][j]);
                }
            }
        }

        max_distance
    }
}