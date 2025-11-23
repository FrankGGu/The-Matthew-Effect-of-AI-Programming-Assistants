use std::collections::VecDeque;

impl Solution {
    pub fn min_push_box(grid: Vec<Vec<char>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut player_start = (0, 0);
        let mut box_start = (0, 0);
        let mut target = (0, 0);

        for i in 0..m {
            for j in 0..n {
                match grid[i][j] {
                    'S' => player_start = (i, j),
                    'B' => box_start = (i, j),
                    'T' => target = (i, j),
                    _ => {}
                }
            }
        }

        let mut visited = std::collections::HashSet::<(usize, usize, usize, usize)>::new();
        let mut queue = VecDeque::new();
        queue.push_back((box_start.0, box_start.1, player_start.0, player_start.1, 0));
        visited.insert((box_start.0, box_start.1, player_start.0, player_start.1));

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((bx, by, px, py, moves)) = queue.pop_front() {
            if (bx, by) == target {
                return moves;
            }

            for (dx, dy) in directions {
                let new_bx = (bx as i32 + dx) as usize;
                let new_by = (by as i32 + dy) as usize;

                if new_bx < m && new_by < n && grid[new_bx][new_by] != '#' {
                    let new_px = bx;
                    let new_py = by;

                    if Self::can_reach(&grid, (px, py), (new_px, new_py), (bx, by)) {
                        if visited.insert((new_bx, new_by, bx, by)) {
                            queue.push_back((new_bx, new_by, bx, by, moves + 1));
                        }
                    }
                }
            }
        }

        -1
    }

    fn can_reach(grid: &Vec<Vec<char>>, start: (usize, usize), end: (usize, usize), box_pos: (usize, usize)) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        let mut visited = std::collections::HashSet::<(usize, usize)>::new();
        let mut queue = VecDeque::new();
        queue.push_back(start);
        visited.insert(start);

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((x, y)) = queue.pop_front() {
            if (x, y) == end {
                return true;
            }

            for (dx, dy) in directions {
                let new_x = (x as i32 + dx) as usize;
                let new_y = (y as i32 + dy) as usize;

                if new_x < m && new_y < n && grid[new_x][new_y] != '#' && (new_x, new_y) != box_pos && visited.insert((new_x, new_y)) {
                    queue.push_back((new_x, new_y));
                }
            }
        }

        false
    }
}