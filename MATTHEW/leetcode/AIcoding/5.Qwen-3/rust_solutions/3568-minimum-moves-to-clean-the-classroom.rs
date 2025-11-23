impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_moves_to_clean_the_classroom(room: Vec<Vec<char>>) -> i32 {
        let (rows, cols) = (room.len(), room[0].len());
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();
        let mut start_pos = (0, 0);

        for i in 0..rows {
            for j in 0..cols {
                if room[i][j] == 'S' {
                    start_pos = (i, j);
                } else if room[i][j] == 'B' {
                    queue.push_back((i, j, 0));
                    visited.insert((i, j));
                }
            }
        }

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((r, c, steps)) = queue.pop_front() {
            if room[r][c] == 'S' {
                return steps;
            }

            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    let (nr, nc) = (nr as usize, nc as usize);
                    if !visited.contains(&(nr, nc)) && room[nr][nc] != '#' {
                        visited.insert((nr, nc));
                        queue.push_back((nr, nc, steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}