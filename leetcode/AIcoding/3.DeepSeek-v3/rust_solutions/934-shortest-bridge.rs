use std::collections::VecDeque;

impl Solution {
    pub fn shortest_bridge(mut grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut queue = VecDeque::new();
        let mut found = false;

        for i in 0..n {
            if found {
                break;
            }
            for j in 0..m {
                if grid[i][j] == 1 {
                    Self::dfs(&mut grid, i, j, &mut queue);
                    found = true;
                    break;
                }
            }
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (x, y) = queue.pop_front().unwrap();
                for (dx, dy) in dirs.iter() {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && nx < n as i32 && ny >= 0 && ny < m as i32 {
                        let nx = nx as usize;
                        let ny = ny as usize;
                        if grid[nx][ny] == 1 {
                            return steps;
                        }
                        if grid[nx][ny] == 0 {
                            grid[nx][ny] = 2;
                            queue.push_back((nx, ny));
                        }
                    }
                }
            }
            steps += 1;
        }

        steps
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, x: usize, y: usize, queue: &mut VecDeque<(usize, usize)>) {
        let n = grid.len();
        let m = grid[0].len();
        if x >= n || y >= m || grid[x][y] != 1 {
            return;
        }
        grid[x][y] = 2;
        queue.push_back((x, y));
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        for (dx, dy) in dirs.iter() {
            let nx = x as i32 + dx;
            let ny = y as i32 + dy;
            if nx >= 0 && nx < n as i32 && ny >= 0 && ny < m as i32 {
                Self::dfs(grid, nx as usize, ny as usize, queue);
            }
        }
    }
}