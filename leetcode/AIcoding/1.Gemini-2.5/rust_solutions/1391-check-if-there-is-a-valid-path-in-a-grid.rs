use std::collections::VecDeque;

impl Solution {
    pub fn has_valid_path(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        // street_connections[street_type - 1] -> Vec<(dr, dc)>
        // (dr, dc) are the relative coordinates for allowed exits from the current cell
        // For example, street 1 (horizontal) allows exits to (0, -1) (left) and (0, 1) (right).
        let street_connections = vec![
            vec![(0, -1), (0, 1)], // 1: left, right
            vec![(-1, 0), (1, 0)], // 2: up, down
            vec![(0, -1), (1, 0)], // 3: left, down
            vec![(0, 1), (1, 0)],  // 4: right, down
            vec![(0, -1), (-1, 0)],// 5: left, up
            vec![(0, 1), (-1, 0)], // 6: right, up
        ];

        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();

        queue.push_back((0, 0));
        visited[0][0] = true;

        while let Some((r, c)) = queue.pop_front() {
            if r == m - 1 && c == n - 1 {
                return true;
            }

            let current_street_type = grid[r][c] as usize;
            let possible_exits = &street_connections[current_street_type - 1];

            for &(dr, dc) in possible_exits {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;

                // Check bounds
                if nr < 0 || nr >= m as i32 || nc < 0 || nc >= n as i32 {
                    continue;
                }

                let nr_usize = nr as usize;
                let nc_usize = nc as usize;

                // Check if already visited
                if visited[nr_usize][nc_usize] {
                    continue;
                }

                // Check if the neighbor street can connect back to the current cell.
                // If we moved from (r, c) to (nr, nc) via (dr, dc),
                // then the neighbor (nr, nc) must have an opening that connects back in direction (-dr, -dc).
                let neighbor_street_type = grid[nr_usize][nc_usize] as usize;
                let required_entry_dir = (-dr, -dc); 

                let neighbor_possible_exits = &street_connections[neighbor_street_type - 1];

                if neighbor_possible_exits.contains(&required_entry_dir) {
                    visited[nr_usize][nc_usize] = true;
                    queue.push_back((nr_usize, nc_usize));
                }
            }
        }

        false 
    }
}