use std::collections::VecDeque;

impl Solution {
    pub fn kth_nearest_obstacle(grid: Vec<Vec<i32>>, queries: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut result = Vec::new();

        for query in queries {
            let r = query[0] as usize;
            let c = query[1] as usize;
            let kth = query[2] as i32;

            let mut visited = vec![vec![false; n]; m];
            let mut queue = VecDeque::new();
            queue.push_back((r, c, 0));
            visited[r][c] = true;

            let mut obstacles = Vec::new();

            while !queue.is_empty() {
                let (row, col, dist) = queue.pop_front().unwrap();

                if grid[row][col] == 1 {
                    obstacles.push((dist, row as i32, col as i32));
                }

                if obstacles.len() as i32 >= kth {
                    break;
                }

                let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
                for (dr, dc) in directions {
                    let new_row = row as i32 + dr;
                    let new_col = col as i32 + dc;

                    if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                        let new_row_usize = new_row as usize;
                        let new_col_usize = new_col as usize;

                        if !visited[new_row_usize][new_col_usize] {
                            visited[new_row_usize][new_col_usize] = true;
                            queue.push_back((new_row_usize, new_col_usize, dist + 1));
                        }
                    }
                }
            }

            if obstacles.len() as i32 >= kth {
                obstacles.sort();
                let (dist, row, col) = obstacles[(kth - 1) as usize];
                result.push(row * n as i32 + col);
            } else {
                result.push(-1);
            }
        }

        result
    }
}