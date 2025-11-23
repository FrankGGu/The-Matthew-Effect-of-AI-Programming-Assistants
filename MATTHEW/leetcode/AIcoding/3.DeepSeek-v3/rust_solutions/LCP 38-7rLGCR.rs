use std::collections::VecDeque;

impl Solution {
    pub fn guard_castle(grid: Vec<String>) -> i32 {
        let grid: Vec<Vec<char>> = grid.into_iter().map(|s| s.chars().collect()).collect();
        let n = grid.len();
        let m = grid[0].len();
        let mut portals = vec![];
        let mut starts = vec![];
        let mut ends = vec![];
        for i in 0..n {
            for j in 0..m {
                match grid[i][j] {
                    'P' => portals.push((i, j)),
                    'S' => starts.push((i, j)),
                    'C' => ends.push((i, j)),
                    _ => (),
                }
            }
        }
        if starts.is_empty() || ends.is_empty() {
            return -1;
        }
        let start = starts[0];
        let end = ends[0];
        let mut dist = vec![vec![std::i32::MAX; m]; n];
        let mut q = VecDeque::new();
        dist[start.0][start.1] = 0;
        q.push_back(start);
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        while let Some((x, y)) = q.pop_front() {
            for &(dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < n as i32 && ny >= 0 && ny < m as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if grid[nx][ny] == '#' {
                        continue;
                    }
                    let new_dist = dist[x][y] + if grid[nx][ny] == 'P' { 0 } else { 1 };
                    if new_dist < dist[nx][ny] {
                        dist[nx][ny] = new_dist;
                        if grid[nx][ny] == 'P' {
                            q.push_front((nx, ny));
                        } else {
                            q.push_back((nx, ny));
                        }
                    }
                }
            }
        }
        if dist[end.0][end.1] == std::i32::MAX {
            -1
        } else {
            dist[end.0][end.1]
        }
    }
}