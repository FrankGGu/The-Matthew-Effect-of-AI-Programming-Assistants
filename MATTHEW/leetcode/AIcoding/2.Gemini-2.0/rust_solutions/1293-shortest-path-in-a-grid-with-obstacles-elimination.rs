use std::collections::VecDeque;

impl Solution {
    pub fn shortest_path(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        if m == 1 && n == 1 {
            return 0;
        }

        let mut visited = vec![vec![vec![false; (k + 1) as usize]; n]; m];
        let mut queue = VecDeque::new();

        queue.push_back((0, 0, k, 0));
        visited[0][0][k as usize] = true;

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while !queue.is_empty() {
            let (row, col, remaining_k, steps) = queue.pop_front().unwrap();

            for (dr, dc) in directions.iter() {
                let new_row = row as i32 + dr;
                let new_col = col as i32 + dc;

                if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                    let new_row = new_row as usize;
                    let new_col = new_col as usize;

                    if grid[new_row][new_col] == 0 {
                        if !visited[new_row][new_col][remaining_k as usize] {
                            visited[new_row][new_col][remaining_k as usize] = true;
                            if new_row == m - 1 && new_col == n - 1 {
                                return steps + 1;
                            }
                            queue.push_back((new_row, new_col, remaining_k, steps + 1));
                        }
                    } else if remaining_k > 0 {
                        if !visited[new_row][new_col][(remaining_k - 1) as usize] {
                            visited[new_row][new_col][(remaining_k - 1) as usize] = true;
                            if new_row == m - 1 && new_col == n - 1 {
                                return steps + 1;
                            }
                            queue.push_back((new_row, new_col, remaining_k - 1, steps + 1));
                        }
                    }
                }
            }
        }

        -1
    }
}