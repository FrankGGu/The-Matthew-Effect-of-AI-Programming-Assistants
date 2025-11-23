impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn shortest_path_all_keys(grid: Vec<String>) -> i32 {
        let mut start_pos = (0, 0);
        let mut key_count = 0;
        let rows = grid.len();
        let cols = grid[0].len();

        for i in 0..rows {
            for j in 0..cols {
                let c = grid[i].chars().nth(j).unwrap();
                if c == '@' {
                    start_pos = (i, j);
                } else if c.is_ascii_lowercase() {
                    key_count += 1;
                }
            }
        }

        let target_mask = (1 << key_count) - 1;
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        let start_state = (start_pos.0, start_pos.1, 0);
        queue.push_back((start_pos.0, start_pos.1, 0, 0));
        visited.insert((start_pos.0, start_pos.1, 0));

        while let Some((x, y, mask, steps)) = queue.pop_front() {
            if mask == target_mask {
                return steps;
            }

            for &(dx, dy) in &directions {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && ny >= 0 && nx < rows as i32 && ny < cols as i32 {
                    let new_x = nx as usize;
                    let new_y = ny as usize;
                    let c = grid[new_x].chars().nth(new_y).unwrap();

                    if c == '#' {
                        continue;
                    }

                    let new_mask = if c.is_ascii_lowercase() {
                        mask | (1 << (c as u8 - b'a' as u8))
                    } else {
                        mask
                    };

                    if !visited.contains(&(new_x, new_y, new_mask)) {
                        visited.insert((new_x, new_y, new_mask));
                        queue.push_back((new_x, new_y, new_mask, steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}