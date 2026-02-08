impl Solution {
    pub fn has_valid_path(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut queue = std::collections::VecDeque::new();

        queue.push_back((0, 0));
        visited[0][0] = true;

        while let Some((row, col)) = queue.pop_front() {
            if row == m - 1 && col == n - 1 {
                return true;
            }

            let street = grid[row][col];
            let directions = match street {
                1 => vec![(0, 1), (0, -1)],
                2 => vec![(1, 0), (-1, 0)],
                3 => vec![(0, -1), (1, 0)],
                4 => vec![(0, 1), (1, 0)],
                5 => vec![(0, -1), (-1, 0)],
                6 => vec![(0, 1), (-1, 0)],
                _ => vec![],
            };

            for (dr, dc) in directions {
                let new_row = row as i32 + dr;
                let new_col = col as i32 + dc;

                if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                    let new_row = new_row as usize;
                    let new_col = new_col as usize;

                    let next_street = grid[new_row][new_col];

                    let can_connect = match (street, next_street) {
                        (1, 1) => (dr == 0),
                        (1, 3) => (dr == 0 && dc == 1),
                        (1, 4) => (dr == 0 && dc == -1),
                        (1, 5) => (dr == 0 && dc == 1),
                        (1, 6) => (dr == 0 && dc == -1),
                        (2, 2) => (dc == 0),
                        (2, 3) => (dr == -1 && dc == 0),
                        (2, 4) => (dr == -1 && dc == 0),
                        (2, 5) => (dr == 1 && dc == 0),
                        (2, 6) => (dr == 1 && dc == 0),
                        (3, 1) => (dr == 0 && dc == -1),
                        (3, 2) => (dr == 1 && dc == 0),
                        (3, 5) => (dr == 1 && dc == 0),
                        (3, 6) => (dr == 0 && dc == -1),
                        (4, 1) => (dr == 0 && dc == 1),
                        (4, 2) => (dr == 1 && dc == 0),
                        (4, 5) => (dr == 0 && dc == 1),
                        (4, 6) => (dr == 1 && dc == 0),
                        (5, 1) => (dr == 0 && dc == -1),
                        (5, 2) => (dr == -1 && dc == 0),
                        (5, 3) => (dr == -1 && dc == 0),
                        (5, 4) => (dr == 0 && dc == -1),
                        (6, 1) => (dr == 0 && dc == 1),
                        (6, 2) => (dr == -1 && dc == 0),
                        (6, 3) => (dr == 0 && dc == 1),
                        (6, 4) => (dr == -1 && dc == 0),
                        _ => false,
                    };

                    if !visited[new_row][new_col] && can_connect {
                        queue.push_back((new_row, new_col));
                        visited[new_row][new_col] = true;
                    }
                }
            }
        }

        false
    }
}