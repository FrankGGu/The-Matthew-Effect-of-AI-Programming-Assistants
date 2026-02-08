use std::collections::VecDeque;

impl Solution {
    pub fn nearest_exit(maze: Vec<Vec<char>>, entrance: Vec<i32>) -> i32 {
        let m = maze.len();
        let n = maze[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();
        let entrance_row = entrance[0] as usize;
        let entrance_col = entrance[1] as usize;
        queue.push_back((entrance_row, entrance_col, 0));
        visited[entrance_row][entrance_col] = true;

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((row, col, steps)) = queue.pop_front() {
            if (row == 0 || row == m - 1 || col == 0 || col == n - 1) &&
               (row != entrance_row || col != entrance_col) {
                return steps;
            }

            for (dr, dc) in directions {
                let new_row = row as i32 + dr;
                let new_col = col as i32 + dc;

                if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                    let new_row_usize = new_row as usize;
                    let new_col_usize = new_col as usize;

                    if maze[new_row_usize][new_col_usize] == '.' && !visited[new_row_usize][new_col_usize] {
                        queue.push_back((new_row_usize, new_col_usize, steps + 1));
                        visited[new_row_usize][new_col_usize] = true;
                    }
                }
            }
        }

        -1
    }
}