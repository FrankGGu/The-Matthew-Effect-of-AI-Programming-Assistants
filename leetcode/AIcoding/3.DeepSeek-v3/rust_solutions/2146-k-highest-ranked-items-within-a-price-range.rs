use std::collections::VecDeque;

impl Solution {
    pub fn highest_ranked_k_items(grid: Vec<Vec<i32>>, pricing: Vec<i32>, start: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let (m, n) = (grid.len(), grid[0].len());
        let (low, high) = (pricing[0], pricing[1]);
        let (start_x, start_y) = (start[0] as usize, start[1] as usize);
        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();
        let mut candidates = Vec::new();

        if grid[start_x][start_y] >= low && grid[start_x][start_y] <= high {
            candidates.push((0, grid[start_x][start_y], start_x, start_y));
        }
        visited[start_x][start_y] = true;
        queue.push_back((start_x, start_y, 0));

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((x, y, dist)) = queue.pop_front() {
            for (dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let (nx, ny) = (nx as usize, ny as usize);
                    if !visited[nx][ny] && grid[nx][ny] != 0 {
                        visited[nx][ny] = true;
                        let new_dist = dist + 1;
                        queue.push_back((nx, ny, new_dist));
                        if grid[nx][ny] >= low && grid[nx][ny] <= high {
                            candidates.push((new_dist, grid[nx][ny], nx, ny));
                        }
                    }
                }
            }
        }

        candidates.sort_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else if a.1 != b.1 {
                a.1.cmp(&b.1)
            } else if a.2 != b.2 {
                a.2.cmp(&b.2)
            } else {
                a.3.cmp(&b.3)
            }
        });

        candidates.into_iter().take(k as usize).map(|(_, _, x, y)| vec![x as i32, y as i32]).collect()
    }
}