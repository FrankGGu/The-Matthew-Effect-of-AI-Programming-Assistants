use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn min_cost(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dist = vec![vec![i32::MAX; n]; m];
        let mut deque = VecDeque::new();

        dist[0][0] = 0;
        deque.push_front((0, 0)); // (row, col)

        // Directions: R, L, D, U
        // Corresponds to grid values: 1, 2, 3, 4
        let dr = [0, 0, 1, -1];
        let dc = [1, -1, 0, 0];

        while let Some((r, c)) = deque.pop_front() {
            for i in 0..4 {
                let nr = r as isize + dr[i];
                let nc = c as isize + dc[i];

                if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    // grid[r][c] is 1-indexed direction
                    // 1: right (dr[0], dc[0])
                    // 2: left (dr[1], dc[1])
                    // 3: down (dr[2], dc[2])
                    // 4: up (dr[3], dc[3])
                    let current_sign_dir_idx = (grid[r][c] - 1) as usize;

                    let cost = if i == current_sign_dir_idx {
                        0
                    } else {
                        1
                    };

                    if dist[r][c] + cost < dist[nr][nc] {
                        dist[nr][nc] = dist[r][c] + cost;
                        if cost == 0 {
                            deque.push_front((nr, nc));
                        } else {
                            deque.push_back((nr, nc));
                        }
                    }
                }
            }
        }

        dist[m - 1][n - 1]
    }
}