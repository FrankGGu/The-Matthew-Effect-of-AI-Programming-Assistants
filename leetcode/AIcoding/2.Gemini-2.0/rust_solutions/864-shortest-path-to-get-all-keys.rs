use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn shortest_path_all_keys(grid: Vec<String>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut start = (0, 0);
        let mut all_keys = 0;

        for i in 0..m {
            for j in 0..n {
                let c = grid[i].as_bytes()[j] as char;
                if c == '@' {
                    start = (i, j);
                } else if c.is_ascii_lowercase() {
                    all_keys |= 1 << (c as u8 - 'a' as u8);
                }
            }
        }

        let mut queue = VecDeque::new();
        queue.push_back((start.0, start.1, 0, 0));

        let mut visited: HashSet<(usize, usize, i32)> = HashSet::new();
        visited.insert((start.0, start.1, 0));

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while !queue.is_empty() {
            let (x, y, keys, steps) = queue.pop_front().unwrap();

            if keys == all_keys {
                return steps;
            }

            for (dx, dy) in directions {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    let c = grid[nx].as_bytes()[ny] as char;

                    if c == '#' {
                        continue;
                    }

                    if c.is_ascii_uppercase() && (keys & (1 << (c as u8 - 'A' as u8))) == 0 {
                        continue;
                    }

                    let mut new_keys = keys;
                    if c.is_ascii_lowercase() {
                        new_keys |= 1 << (c as u8 - 'a' as u8);
                    }

                    if !visited.contains(&(nx, ny, new_keys)) {
                        visited.insert((nx, ny, new_keys));
                        queue.push_back((nx, ny, new_keys, steps + 1));
                    }
                }
            }
        }

        -1
    }
}