struct Solution;

impl Solution {
    // memo values: 0 = unvisited, -1 = visiting (in current path), >0 = visited and computed
    fn dfs(r: usize, c: usize, m: usize, n: usize, grid: &Vec<Vec<i32>>, memo: &mut Vec<Vec<i32>>) -> i32 {
        if memo[r][c] != 0 {
            // If memo[r][c] is -1, it means we've detected a cycle in the current path.
            // According to the "distinct cells" rule, we cannot extend this path further through this cycle.
            // So, we return -1, which will be handled by the caller to ignore this branch.
            // If memo[r][c] is >0, it's a previously computed valid path length, so return it.
            return memo[r][c];
        }

        // Mark the current cell as being visited to detect cycles
        memo[r][c] = -1;

        let mut max_len = 1; // A single cell itself forms a path of length 1
        let current_val = grid[r][c];

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r as i32 + dr[i];
            let nc = c as i32 + dc[i];

            if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                let nr = nr as usize;
                let nc = nc as usize;

                let neighbor_val = grid[nr][nc];

                // Check the divisibility rule: current_val must be a multiple of neighbor_val.
                // This means we can move from (nr, nc) to (r, c).
                // So, we are looking for paths ending at (nr, nc) that can be extended to (r, c).
                if current_val % neighbor_val == 0 {
                    let prev_path_len = Self::dfs(nr, nc, m, n, grid, memo);

                    // Only consider valid path lengths from neighbors (not cycles)
                    if prev_path_len != -1 {
                        max_len = max_len.max(1 + prev_path_len);
                    }
                }
            }
        }

        // Store the computed maximum path length ending at (r, c)
        memo[r][c] = max_len;
        max_len
    }

    pub fn longest_special_path(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        // memoization table initialized with 0s (unvisited)
        let mut memo = vec![vec![0; n]; m];
        // The problem states to return 1 if no special path exists.
        // A single cell always forms a special path of length 1.
        let mut overall_max_len = 1;

        // Iterate through all cells, treating each as a potential endpoint of a longest path
        for r in 0..m {
            for c in 0..n {
                overall_max_len = overall_max_len.max(Self::dfs(r, c, m, n, &grid, &mut memo));
            }
        }

        overall_max_len
    }
}