use std::collections::VecDeque;

impl Solution {
    pub fn shortest_bridge(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut grid = grid;
        let mut queue = VecDeque::new();
        let mut found = false;

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    let mut q = VecDeque::new();
                    q.push_back((i, j));
                    grid[i][j] = 2;

                    while let Some((x, y)) = q.pop_front() {
                        queue.push_back((x, y));

                        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
                        for (dx, dy) in directions {
                            let nx = x as i32 + dx;
                            let ny = y as i32 + dy;

                            if nx >= 0 && nx < n as i32 && ny >= 0 && ny < n as i32 {
                                let nx = nx as usize;
                                let ny = ny as usize;

                                if grid[nx][ny] == 1 {
                                    grid[nx][ny] = 2;
                                    q.push_back((nx, ny));
                                    queue.push_back((nx, ny));
                                }
                            }
                        }
                    }
                    found = true;
                    break;
                }
            }
            if found {
                break;
            }
        }

        let mut steps = 0;
        while !queue.is_empty() {
            let len = queue.len();
            for _ in 0..len {
                let (x, y) = queue.pop_front().unwrap();

                let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
                for (dx, dy) in directions {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;

                    if nx >= 0 && nx < n as i32 && ny >= 0 && ny < n as i32 {
                        let nx = nx as usize;
                        let ny = ny as usize;

                        if grid[nx][ny] == 1 {
                            return steps;
                        } else if grid[nx][ny] == 0 {
                            grid[nx][ny] = 2;
                            queue.push_back((nx, ny));
                        }
                    }
                }
            }
            steps += 1;
        }

        0
    }
}