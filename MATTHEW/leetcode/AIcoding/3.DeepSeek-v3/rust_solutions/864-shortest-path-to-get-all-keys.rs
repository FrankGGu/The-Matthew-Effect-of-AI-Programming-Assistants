use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn shortest_path_all_keys(grid: Vec<String>) -> i32 {
        let grid: Vec<Vec<char>> = grid.iter().map(|s| s.chars().collect()).collect();
        let m = grid.len();
        let n = grid[0].len();
        let mut start_x = 0;
        let mut start_y = 0;
        let mut key_count = 0;

        for i in 0..m {
            for j in 0..n {
                let c = grid[i][j];
                if c == '@' {
                    start_x = i;
                    start_y = j;
                } else if c.is_ascii_lowercase() {
                    key_count += 1;
                }
            }
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((start_x, start_y, 0));
        visited.insert((start_x, start_y, 0));
        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (x, y, keys) = queue.pop_front().unwrap();
                if keys == (1 << key_count) - 1 {
                    return steps;
                }
                for &(dx, dy) in dirs.iter() {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                        let nx = nx as usize;
                        let ny = ny as usize;
                        let c = grid[nx][ny];
                        if c == '#' {
                            continue;
                        }
                        let mut new_keys = keys;
                        if c.is_ascii_lowercase() {
                            new_keys |= 1 << (c as u8 - b'a');
                        }
                        if c.is_ascii_uppercase() && (keys & (1 << (c as u8 - b'A'))) == 0 {
                            continue;
                        }
                        if !visited.contains(&(nx, ny, new_keys)) {
                            visited.insert((nx, ny, new_keys));
                            queue.push_back((nx, ny, new_keys));
                        }
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}