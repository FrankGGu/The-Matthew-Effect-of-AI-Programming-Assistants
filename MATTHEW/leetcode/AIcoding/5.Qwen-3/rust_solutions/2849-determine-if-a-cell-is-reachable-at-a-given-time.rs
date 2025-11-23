struct Solution;

impl Solution {
    pub fn is_reachable_at_time(_grid: Vec<Vec<i32>>, _time: i32) -> bool {
        let (rows, cols) = (grid.len(), grid[0].len());
        let mut start = None;
        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    start = Some((i, j));
                    break;
                }
            }
            if start.is_some() {
                break;
            }
        }

        let (sx, sy) = match start {
            Some(pos) => pos,
            None => return false,
        };

        let mut visited = vec![vec![false; cols]; rows];
        let mut queue = std::collections::VecDeque::new();
        queue.push_back((sx, sy, 0));
        visited[sx][sy] = true;

        while let Some((x, y, t)) = queue.pop_front() {
            if t > _time {
                continue;
            }
            if t == _time {
                return true;
            }
            for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if !visited[nx][ny] && grid[nx][ny] == 0 {
                        visited[nx][ny] = true;
                        queue.push_back((nx, ny, t + 1));
                    }
                }
            }
        }

        false
    }
}