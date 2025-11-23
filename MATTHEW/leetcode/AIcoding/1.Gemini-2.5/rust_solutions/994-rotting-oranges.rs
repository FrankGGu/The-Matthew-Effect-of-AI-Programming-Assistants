use std::collections::VecDeque;

impl Solution {
    pub fn oranges_rotting(mut grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut queue: VecDeque<(usize, usize)> = VecDeque::new();
        let mut fresh_oranges = 0;

        for r in 0..rows {
            for c in 0..cols {
                match grid[r][c] {
                    1 => fresh_oranges += 1,
                    2 => queue.push_back((r, c)),
                    _ => {}
                }
            }
        }

        if fresh_oranges == 0 {
            return 0;
        }

        let mut minutes = 0;
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while !queue.is_empty() {
            let current_level_size = queue.len();
            let mut any_rotted_in_this_minute = false;

            for _ in 0..current_level_size {
                let (r, c) = queue.pop_front().unwrap();

                for (dr, dc) in &directions {
                    let nr = r as isize + dr;
                    let nc = c as isize + dc;

                    if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                        let nr = nr as usize;
                        let nc = nc as usize;

                        if grid[nr][nc] == 1 {
                            grid[nr][nc] = 2;
                            fresh_oranges -= 1;
                            queue.push_back((nr, nc));
                            any_rotted_in_this_minute = true;
                        }
                    }
                }
            }

            if any_rotted_in_this_minute {
                minutes += 1;
            }
        }

        if fresh_oranges == 0 {
            minutes
        } else {
            -1
        }
    }
}