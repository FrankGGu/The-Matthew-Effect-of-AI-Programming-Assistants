use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn shortest_path_all_keys(grid: Vec<String>) -> i32 {
        let m = grid.len() as i32;
        let n = grid[0].len() as i32;

        let mut start_r = -1;
        let mut start_c = -1;
        let mut target_all_keys_mask = 0;

        let grid_chars: Vec<Vec<char>> = grid.iter().map(|s| s.chars().collect()).collect();

        for r in 0..m {
            for c in 0..n {
                let cell = grid_chars[r as usize][c as usize];
                if cell == '@' {
                    start_r = r;
                    start_c = c;
                } else if cell >= 'a' && cell <= 'f' {
                    target_all_keys_mask |= 1 << (cell as u8 - b'a');
                }
            }
        }

        let mut queue: VecDeque<(i32, i32, u8, i32)> = VecDeque::new(); // (row, col, keys_mask, steps)
        let mut visited: HashSet<(i32, i32, u8)> = HashSet::new();

        queue.push_back((start_r, start_c, 0, 0));
        visited.insert((start_r, start_c, 0));

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c, current_keys, steps)) = queue.pop_front() {
            if current_keys == target_all_keys_mask {
                return steps;
            }

            for i in 0..4 {
                let nr = r + dr[i];
                let nc = c + dc[i];

                if nr >= 0 && nr < m && nc >= 0 && nc < n {
                    let cell = grid_chars[nr as usize][nc as usize];

                    if cell == '#' {
                        continue; // Wall
                    }

                    if cell >= 'a' && cell <= 'f' { // Key
                        let key_bit = 1 << (cell as u8 - b'a');
                        let new_keys = current_keys | key_bit;
                        if visited.insert((nr, nc, new_keys)) {
                            queue.push_back((nr, nc, new_keys, steps + 1));
                        }
                    } else if cell >= 'A' && cell <= 'F' { // Lock
                        let lock_bit = 1 << (cell as u8 - b'A');
                        if (current_keys & lock_bit) != 0 { // Have the key
                            if visited.insert((nr, nc, current_keys)) {
                                queue.push_back((nr, nc, current_keys, steps + 1));
                            }
                        }
                    } else { // Empty cell '.' or starting point '@'
                        if visited.insert((nr, nc, current_keys)) {
                            queue.push_back((nr, nc, current_keys, steps + 1));
                        }
                    }
                }
            }
        }

        -1 // No path found
    }
}