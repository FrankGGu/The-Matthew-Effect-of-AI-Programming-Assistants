use std::collections::{HashSet, VecDeque};

pub fn shortest_path_all_keys(grid: Vec<String>) -> i32 {
    let m = grid.len();
    let n = grid[0].len();
    let mut start = (0, 0);
    let mut total_keys = 0;

    for i in 0..m {
        for j in 0..n {
            if grid[i].chars().nth(j).unwrap() == '@' {
                start = (i, j);
            } else if grid[i].chars().nth(j).unwrap().is_ascii_lowercase() {
                total_keys += 1;
            }
        }
    }

    let target_mask = (1 << total_keys) - 1;
    let mut visited = vec![vec![vec![false; 1 << total_keys]; n]; m];
    let mut queue = VecDeque::new();
    queue.push_back((start.0, start.1, 0, 0));
    visited[start.0][start.1][0] = true;

    let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];
    let mut steps = 0;

    while !queue.is_empty() {
        let size = queue.len();
        for _ in 0..size {
            let (x, y, keys, steps) = queue.pop_front().unwrap();
            if keys == target_mask {
                return steps;
            }
            for (dx, dy) in &directions {
                let (nx, ny) = (x as isize + dx, y as isize + dy);
                if nx < 0 || nx >= m as isize || ny < 0 || ny >= n as isize {
                    continue;
                }
                let cell = grid[nx as usize].chars().nth(ny as usize).unwrap();
                if cell == '#' {
                    continue;
                }
                let mut new_keys = keys;
                if cell.is_ascii_lowercase() {
                    new_keys |= 1 << (cell as u8 - b'a');
                } else if cell.is_ascii_uppercase() {
                    let key_bit = 1 << (cell as u8 - b'A');
                    if keys & key_bit == 0 {
                        continue;
                    }
                }
                if !visited[nx as usize][ny as usize][new_keys] {
                    visited[nx as usize][ny as usize][new_keys] = true;
                    queue.push_back((nx as usize, ny as usize, new_keys, steps + 1));
                }
            }
        }
        steps += 1;
    }

    -1
}