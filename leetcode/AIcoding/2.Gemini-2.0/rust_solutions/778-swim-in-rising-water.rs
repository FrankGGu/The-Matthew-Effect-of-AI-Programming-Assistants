use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn swim_in_rising_water(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut visited = vec![vec![false; n]; n];
        let mut pq = BinaryHeap::new();
        pq.push(Reverse((grid[0][0], 0, 0)));
        visited[0][0] = true;
        let mut ans = 0;

        let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while !pq.is_empty() {
            let Reverse((height, row, col)) = pq.pop().unwrap();
            ans = ans.max(height);

            if row == n - 1 && col == n - 1 {
                return ans;
            }

            for (dr, dc) in dirs {
                let new_row = row as i32 + dr;
                let new_col = col as i32 + dc;

                if new_row >= 0 && new_row < n as i32 && new_col >= 0 && new_col < n as i32 {
                    let new_row = new_row as usize;
                    let new_col = new_col as usize;

                    if !visited[new_row][new_col] {
                        visited[new_row][new_col] = true;
                        pq.push(Reverse((grid[new_row][new_col], new_row, new_col)));
                    }
                }
            }
        }

        0
    }
}