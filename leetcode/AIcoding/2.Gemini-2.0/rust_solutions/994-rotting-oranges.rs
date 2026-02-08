use std::collections::VecDeque;

impl Solution {
    pub fn oranges_rotting(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut q: VecDeque<(usize, usize, i32)> = VecDeque::new();
        let mut fresh_count = 0;

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 2 {
                    q.push_back((i, j, 0));
                } else if grid[i][j] == 1 {
                    fresh_count += 1;
                }
            }
        }

        let mut minutes = 0;
        let directions: [(i32, i32); 4] = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((row, col, time)) = q.pop_front() {
            minutes = time.max(minutes);

            for (dr, dc) in directions {
                let new_row = row as i32 + dr;
                let new_col = col as i32 + dc;

                if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                    let new_row_usize = new_row as usize;
                    let new_col_usize = new_col as usize;

                    if grid[new_row_usize][new_col_usize] == 1 {
                        grid[new_row_usize][new_col_usize] = 2;
                        fresh_count -= 1;
                        q.push_back((new_row_usize, new_col_usize, time + 1));
                    }
                }
            }
        }

        if fresh_count == 0 {
            minutes
        } else {
            -1
        }
    }
}