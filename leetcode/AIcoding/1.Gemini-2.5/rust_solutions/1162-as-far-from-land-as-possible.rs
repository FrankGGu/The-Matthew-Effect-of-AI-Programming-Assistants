use std::collections::VecDeque;

impl Solution {
    pub fn max_distance(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();

        let mut queue: VecDeque<(usize, usize)> = VecDeque::new();
        let mut dist: Vec<Vec<i32>> = vec![vec![-1; m]; n];

        let mut has_land = false;
        let mut has_water = false;

        for r in 0..n {
            for c in 0..m {
                if grid[r][c] == 1 {
                    queue.push_back((r, c));
                    dist[r][c] = 0;
                    has_land = true;
                } else {
                    has_water = true;
                }
            }
        }

        if !has_land || !has_water {
            return -1;
        }

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
        let mut max_dist = -1;

        while let Some((r, c)) = queue.pop_front() {
            for (dr, dc) in directions.iter() {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;

                if nr >= 0 && nr < n as i32 && nc >= 0 && nc < m as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    if dist[nr][nc] == -1 {
                        dist[nr][nc] = dist[r][c] + 1;
                        queue.push_back((nr, nc));
                        max_dist = max_dist.max(dist[nr][nc]);
                    }
                }
            }
        }

        max_dist
    }
}