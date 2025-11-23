use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn escape_maze(maze: Vec<Vec<String>>) -> bool {
        let time = maze.len();
        if time == 0 {
            return false;
        }
        let n = maze[0].len();
        if n == 0 {
            return false;
        }
        let m = maze[0][0].len();
        if m == 0 {
            return false;
        }
        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 0, false, false));
        visited.insert((0, 0, false, false));

        while let Some((t, x, y, used_temp, used_perm)) = queue.pop_front() {
            if x == n - 1 && y == m - 1 {
                return true;
            }
            if t + 1 >= time {
                continue;
            }
            for &(dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx < 0 || ny < 0 || nx >= n as i32 || ny >= m as i32 {
                    continue;
                }
                let nx = nx as usize;
                let ny = ny as usize;
                let cell = maze[t + 1][nx].chars().nth(ny).unwrap();
                if cell == '.' {
                    if !visited.contains(&(nx, ny, used_temp, used_perm)) {
                        visited.insert((nx, ny, used_temp, used_perm));
                        queue.push_back((t + 1, nx, ny, used_temp, used_perm));
                    }
                } else {
                    if !used_temp {
                        if !visited.contains(&(nx, ny, true, used_perm)) {
                            visited.insert((nx, ny, true, used_perm));
                            queue.push_back((t + 1, nx, ny, true, used_perm));
                        }
                    }
                    if !used_perm {
                        for k in t + 1..time {
                            let cell_k = maze[k][nx].chars().nth(ny).unwrap();
                            if cell_k == '#' {
                                break;
                            }
                            if !visited.contains(&(nx, ny, used_temp, true)) {
                                visited.insert((nx, ny, used_temp, true));
                                queue.push_back((k, nx, ny, used_temp, true));
                            }
                        }
                    }
                }
            }
        }
        false
    }
}