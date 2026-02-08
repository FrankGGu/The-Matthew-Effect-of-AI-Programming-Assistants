use std::collections::VecDeque;

impl Solution {
    pub fn minimum_obstacle_removal(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX; n]; m];
        let mut deque: VecDeque<(usize, usize)> = VecDeque::new();

        dist[0][0] = 0;
        deque.push_front((0, 0));

        let directions: [(isize, isize); 4] = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((r, c)) = deque.pop_front() {
            for (dr, dc) in directions.iter() {
                let nr = r as isize + dr;
                let nc = c as isize + dc;

                if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;
                    let obstacle_cost = grid[nr][nc];
                    let new_cost = dist[r][c] + obstacle_cost;

                    if new_cost < dist[nr][nc] {
                        dist[nr][nc] = new_cost;
                        if obstacle_cost == 0 {
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