use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn latest_day_to_cross(row: i32, col: i32, cells: Vec<Vec<i32>>) -> i32 {
        let mut low = 1;
        let mut high = cells.len() as i32;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::can_cross(row, col, &cells, mid as usize) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }

    fn can_cross(row: i32, col: i32, cells: &Vec<Vec<i32>>, k: usize) -> bool {
        let mut grid = vec![vec![0; col as usize]; row as usize]; // 0 for land, 1 for water
        for i in 0..k {
            let r = cells[i][0] as usize - 1;
            let c = cells[i][1] as usize - 1;
            grid[r][c] = 1; // Mark as water
        }

        let mut q = VecDeque::new();
        let mut visited = vec![vec![false; col as usize]; row as usize];

        // Add all unblocked cells in the top row to the queue
        for c_idx in 0..col as usize {
            if grid[0][c_idx] == 0 { // If it's land
                q.push_back((0, c_idx));
                visited[0][c_idx] = true;
            }
        }

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((r, c)) = q.pop_front() {
            if r == row as usize - 1 {
                return true; // Reached the bottom row
            }

            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0 && nr < row && nc >= 0 && nc < col {
                    let nr_usize = nr as usize;
                    let nc_usize = nc as usize;
                    if grid[nr_usize][nc_usize] == 0 && !visited[nr_usize][nc_usize] {
                        visited[nr_usize][nc_usize] = true;
                        q.push_back((nr_usize, nc_usize));
                    }
                }
            }
        }

        false // No path found
    }
}