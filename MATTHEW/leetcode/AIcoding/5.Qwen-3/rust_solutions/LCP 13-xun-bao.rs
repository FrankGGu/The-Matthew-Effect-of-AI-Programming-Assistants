impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimal_steps(maze: Vec<Vec<char>>) -> i32 {
        let (rows, cols) = (maze.len(), maze[0].len());
        let mut start_pos = (0, 0);
        let mut end_pos = (0, 0);
        let mut keys = HashSet::new();

        for i in 0..rows {
            for j in 0..cols {
                match maze[i][j] {
                    'S' => start_pos = (i, j),
                    'E' => end_pos = (i, j),
                    'a'..='z' => {
                        keys.insert(maze[i][j]);
                    }
                    _ => {}
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let key_count = keys.len();
        let mut key_positions = Vec::new();

        for &key in &keys {
            for i in 0..rows {
                for j in 0..cols {
                    if maze[i][j] == key {
                        key_positions.push((i, j));
                    }
                }
            }
        }

        let mut dist = vec![vec![vec![-1; key_count]; cols]; rows];
        let mut queue = VecDeque::new();

        for (i, j) in [start_pos, end_pos] {
            for k in 0..key_count {
                if maze[i][j] as u8 - b'a' == k as u8 {
                    dist[i][j][k] = 0;
                    queue.push_back((i, j, k));
                }
            }
        }

        while let Some((x, y, k)) = queue.pop_front() {
            for &(dx, dy) in &directions {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && ny >= 0 && nx < rows as i32 && ny < cols as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;

                    if maze[nx][ny] == '#' {
                        continue;
                    }

                    let new_k = if maze[nx][ny] >= 'a' && maze[nx][ny] <= 'z' {
                        let idx = maze[nx][ny] as u8 - b'a';
                        idx as usize
                    } else {
                        k
                    };

                    if dist[nx][ny][new_k] == -1 {
                        dist[nx][ny][new_k] = dist[x][y][k] + 1;
                        queue.push_back((nx, ny, new_k));
                    }
                }
            }
        }

        let end_key = maze[end_pos.0][end_pos.1] as u8 - b'a' as u8;
        let mut result = i32::MAX;

        for k in 0..key_count {
            if dist[end_pos.0][end_pos.1][k] != -1 {
                result = result.min(dist[end_pos.0][end_pos.1][k]);
            }
        }

        if result == i32::MAX {
            -1
        } else {
            result
        }
    }
}
}