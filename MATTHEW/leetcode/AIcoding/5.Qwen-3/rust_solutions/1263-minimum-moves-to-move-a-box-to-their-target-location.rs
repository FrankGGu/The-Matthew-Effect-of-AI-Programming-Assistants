impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_moves(mut grid: Vec<Vec<char>>) -> i32 {
        let (rows, cols) = (grid.len(), grid[0].len());
        let mut player = (0, 0);
        let mut box_pos = (0, 0);
        let target = (0, 0);

        for i in 0..rows {
            for j in 0..cols {
                match grid[i][j] {
                    'S' => player = (i, j),
                    'B' => box_pos = (i, j),
                    'T' => target = (i, j),
                    _ => {}
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        let mut queue = VecDeque::new();
        queue.push_back((player.0, player.1, box_pos.0, box_pos.1, 0));
        let mut visited = HashSet::new();
        visited.insert((player.0, player.1, box_pos.0, box_pos.1));

        while let Some((px, py, bx, by, steps)) = queue.pop_front() {
            if (bx, by) == target {
                return steps;
            }

            for &(dx, dy) in &directions {
                let np_x = px + dx;
                let np_y = py + dy;

                if np_x >= 0 && np_x < rows as i32 && np_y >= 0 && np_y < cols as i32 {
                    if grid[np_x as usize][np_y as usize] != '#' {
                        if (np_x, np_y) == (bx, by) {
                            let nbx = bx + dx;
                            let nby = by + dy;
                            if nbx >= 0 && nbx < rows as i32 && nby >= 0 && nby < cols as i32 {
                                if grid[nbx as usize][nby as usize] != '#' {
                                    let state = (np_x, np_y, nbx, nby);
                                    if !visited.contains(&state) {
                                        visited.insert(state);
                                        queue.push_back((np_x, np_y, nbx, nby, steps + 1));
                                    }
                                }
                            }
                        } else {
                            let state = (np_x, np_y, bx, by);
                            if !visited.contains(&state) {
                                visited.insert(state);
                                queue.push_back((np_x, np_y, bx, by, steps + 1));
                            }
                        }
                    }
                }
            }
        }

        -1
    }
}

struct Solution;
}