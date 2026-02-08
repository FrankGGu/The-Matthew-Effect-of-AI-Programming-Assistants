use std::collections::VecDeque;

impl Solution {
    pub fn minimum_number_of_visited_cells(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dist = vec![vec![i32::MAX; n]; m];
        dist[0][0] = 1;

        let mut queue = VecDeque::new();
        queue.push_back((0, 0));

        let mut row_reach = vec![0; m];
        let mut col_reach = vec![0; n];

        while let Some((r, c)) = queue.pop_front() {
            if r == m - 1 && c == n - 1 {
                return dist[r][c];
            }

            let reach = grid[r][c] as usize;

            // Explore rows
            if row_reach[r] < reach {
                for nc in (c + 1)..std::cmp::min(c + reach + 1, n) {
                    if dist[r][nc] == i32::MAX {
                        dist[r][nc] = dist[r][c] + 1;
                        queue.push_back((r, nc));
                    }
                }
                row_reach[r] = reach;
            }

            // Explore columns
            if col_reach[c] < reach {
                for nr in (r + 1)..std::cmp::min(r + reach + 1, m) {
                    if dist[nr][c] == i32::MAX {
                        dist[nr][c] = dist[r][c] + 1;
                        queue.push_back((nr, c));
                    }
                }
                col_reach[c] = reach;
            }
        }

        -1
    }
}