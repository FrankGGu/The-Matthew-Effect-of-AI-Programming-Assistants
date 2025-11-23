use std::collections::VecDeque;

impl Solution {
    pub fn max_distance(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut queue = VecDeque::new();
        let mut visited = vec![vec![false; n]; n];

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    queue.push_back((i, j, 0));
                    visited[i][j] = true;
                }
            }
        }

        if queue.is_empty() || queue.len() == n * n {
            return -1;
        }

        let mut max_dist = -1;
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while !queue.is_empty() {
            if let Some((x, y, dist)) = queue.pop_front() {
                max_dist = max_dist.max(dist);

                for (dx, dy) in directions.iter() {
                    let new_x = x as i32 + dx;
                    let new_y = y as i32 + dy;

                    if new_x >= 0 && new_x < n as i32 && new_y >= 0 && new_y < n as i32 {
                        let new_x = new_x as usize;
                        let new_y = new_y as usize;

                        if !visited[new_x][new_y] {
                            visited[new_x][new_y] = true;
                            queue.push_back((new_x, new_y, dist + 1));
                        }
                    }
                }
            }
        }

        max_dist
    }
}