use std::collections::{VecDeque, BinaryHeap};
use std::cmp::{min, Reverse};

impl Solution {
    pub fn maximum_safeness_factor(grid: Vec<Vec<i32>>) -> i32 {
        let r_len = grid.len();
        let c_len = grid[0].len();

        // Step 1: Multi-source BFS to calculate minimum distance to any thief for each cell.
        // dist_to_thief[i][j] stores the minimum Manhattan distance from (i,j) to any thief.
        let mut dist_to_thief = vec![vec![i32::MAX; c_len]; r_len];
        let mut q = VecDeque::new();

        for i in 0..r_len {
            for j in 0..c_len {
                if grid[i][j] == 1 {
                    dist_to_thief[i][j] = 0;
                    q.push_back((i, j));
                }
            }
        }

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some((curr_r, curr_c)) = q.pop_front() {
            for i in 0..4 {
                let nr = curr_r as i32 + dr[i];
                let nc = curr_c as i32 + dc[i];

                if nr >= 0 && nr < r_len as i32 && nc >= 0 && nc < c_len as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;
                    if dist_to_thief[nr][nc] > dist_to_thief[curr_r][curr_c] + 1 {
                        dist_to_thief[nr][nc] = dist_to_thief[curr_r][curr_c] + 1;
                        q.push_back((nr, nc));
                    }
                }
            }
        }

        // Step 2: Dijkstra's algorithm to find the path from (0,0) to (r_len-1, c_len-1)
        // that maximizes the minimum safeness factor along the path.
        // max_min_safety[i][j] stores the maximum possible minimum safeness factor
        // for a path from (0,0) to (i,j).
        let mut max_min_safety = vec![vec![-1; c_len]; r_len];
        // Priority queue stores (safeness_factor, row, col).
        // Rust's BinaryHeap is a min-heap. To simulate a max-heap for safeness_factor,
        // we wrap the safeness_factor in `Reverse`.
        let mut pq = BinaryHeap::new();

        // Initial state: start at (0,0) with safeness factor dist_to_thief[0][0]
        max_min_safety[0][0] = dist_to_thief[0][0];
        pq.push((Reverse(dist_to_thief[0][0]), 0, 0));

        while let Some((Reverse(current_safety), curr_r, curr_c)) = pq.pop() {
            // If we found a path to (curr_r, curr_c) with a higher minimum safety already, skip.
            if current_safety < max_min_safety[curr_r][curr_c] {
                continue;
            }

            // If we reached the destination, this is the maximum possible minimum safeness factor.
            if curr_r == r_len - 1 && curr_c == c_len - 1 {
                return current_safety;
            }

            for i in 0..4 {
                let nr = curr_r as i32 + dr[i];
                let nc = curr_c as i32 + dc[i];

                if nr >= 0 && nr < r_len as i32 && nc >= 0 && nc < c_len as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    // The safeness factor for the path to (nr, nc) is the minimum of
                    // the current path's safeness factor and the safeness of cell (nr, nc).
                    let new_safety = min(current_safety, dist_to_thief[nr][nc]);

                    // If this new path to (nr, nc) has a higher minimum safeness factor
                    // than any previously found path to (nr, nc), update and push to PQ.
                    if new_safety > max_min_safety[nr][nc] {
                        max_min_safety[nr][nc] = new_safety;
                        pq.push((Reverse(new_safety), nr, nc));
                    }
                }
            }
        }

        // This line should be reached if a path from (0,0) to (r_len-1, c_len-1) exists.
        // The problem guarantees a valid grid.
        max_min_safety[r_len - 1][c_len - 1]
    }
}