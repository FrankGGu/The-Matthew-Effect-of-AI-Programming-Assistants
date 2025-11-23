use std::collections::VecDeque;

impl Solution {
    pub fn oranges_rotting(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return -1;
        }
        let cols = grid[0].len();
        let mut queue = VecDeque::new();
        let mut fresh = 0;
        let mut time = 0;

        for r in 0..rows {
            for c in 0..cols {
                match grid[r][c] {
                    2 => queue.push_back((r as i32, c as i32)),
                    1 => fresh += 1,
                    _ => (),
                }
            }
        }

        if fresh == 0 {
            return 0;
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        while !queue.is_empty() && fresh > 0 {
            let size = queue.len();
            for _ in 0..size {
                let (r, c) = queue.pop_front().unwrap();
                for (dr, dc) in dirs.iter() {
                    let nr = r + dr;
                    let nc = c + dc;
                    if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                        let nr = nr as usize;
                        let nc = nc as usize;
                        if grid[nr][nc] == 1 {
                            grid[nr][nc] = 2;
                            queue.push_back((nr as i32, nc as i32));
                            fresh -= 1;
                        }
                    }
                }
            }
            if !queue.is_empty() {
                time += 1;
            }
        }

        if fresh == 0 {
            time
        } else {
            -1
        }
    }
}