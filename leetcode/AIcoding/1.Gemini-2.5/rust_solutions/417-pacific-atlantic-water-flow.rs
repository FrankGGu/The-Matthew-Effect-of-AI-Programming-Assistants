use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn pacific_atlantic(heights: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = heights.len();
        let n = heights[0].len();

        let mut pacific_reachable = vec![vec![false; n]; m];
        let mut atlantic_reachable = vec![vec![false; n]; m];

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        let mut q = VecDeque::new();

        // Initialize BFS for Pacific Ocean
        for r in 0..m {
            q.push_back((r, 0));
            pacific_reachable[r][0] = true;
        }
        for c in 1..n { // Start from 1 to avoid duplicating (0,0)
            q.push_back((0, c));
            pacific_reachable[0][c] = true;
        }

        while let Some((r, c)) = q.pop_front() {
            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr_usize = nr as usize;
                    let nc_usize = nc as usize;
                    if !pacific_reachable[nr_usize][nc_usize] && heights[nr_usize][nc_usize] >= heights[r][c] {
                        pacific_reachable[nr_usize][nc_usize] = true;
                        q.push_back((nr_usize, nc_usize));
                    }
                }
            }
        }

        // Clear queue for Atlantic Ocean
        q.clear();

        // Initialize BFS for Atlantic Ocean
        for r in 0..m {
            q.push_back((r, n - 1));
            atlantic_reachable[r][n - 1] = true;
        }
        for c in 0..n - 1 { // Start from 0 to avoid duplicating (m-1, n-1)
            q.push_back((m - 1, c));
            atlantic_reachable[m - 1][c] = true;
        }

        while let Some((r, c)) = q.pop_front() {
            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr_usize = nr as usize;
                    let nc_usize = nc as usize;
                    if !atlantic_reachable[nr_usize][nc_usize] && heights[nr_usize][nc_usize] >= heights[r][c] {
                        atlantic_reachable[nr_usize][nc_usize] = true;
                        q.push_back((nr_usize, nc_usize));
                    }
                }
            }
        }

        let mut result = Vec::new();
        for r in 0..m {
            for c in 0..n {
                if pacific_reachable[r][c] && atlantic_reachable[r][c] {
                    result.push(vec![r as i32, c as i32]);
                }
            }
        }
        result
    }
}