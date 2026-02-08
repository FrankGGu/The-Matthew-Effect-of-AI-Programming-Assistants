struct Solution;

impl Solution {
    fn dfs(
        grid: &mut Vec<Vec<i32>>,
        r: usize,
        c: usize,
        visited_count: i32, // Counts 0s and 1s visited so far
        total_cells_to_visit: i32, // Total count of 0s and 1s
        paths: &mut i32,
    ) {
        let m = grid.len();
        let n = grid[0].len();

        // Base cases for invalid moves or already visited (if not 2)
        // grid[r][c] == -1 (obstacle) or grid[r][c] == 3 (already visited 0 or 1)
        if r >= m || c >= n || grid[r][c] == -1 || grid[r][c] == 3 {
            return;
        }

        // Reached the end square (2)
        if grid[r][c] == 2 {
            if visited_count == total_cells_to_visit {
                *paths += 1;
            }
            return;
        }

        // Mark current cell (0 or 1) as visited
        let original_val = grid[r][c];
        grid[r][c] = 3; // Mark as visited

        // Explore all 4 directions
        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r as i32 + dr[i];
            let nc = c as i32 + dc[i];

            // Check bounds for nr, nc
            if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                Self::dfs(
                    grid,
                    nr as usize,
                    nc as usize,
                    visited_count + 1, // Increment visited count
                    total_cells_to_visit,
                    paths,
                );
            }
        }

        // Backtrack: unmark current cell
        grid[r][c] = original_val;
    }

    pub fn unique_paths_iii(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut start_r = 0;
        let mut start_c = 0;
        let mut total_cells_to_visit = 0; // Counts 0s and 1s

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    start_r = r;
                    start_c = c;
                    total_cells_to_visit += 1; // Count the start cell
                } else if grid[r][c] == 0 {
                    total_cells_to_visit += 1; // Count empty cells
                }
            }
        }

        let mut paths_count = 0;
        Self::dfs(
            &mut grid,
            start_r,
            start_c,
            0, // Initial visited_count is 0. It will be incremented to 1 when the start cell is processed.
            total_cells_to_visit,
            &mut paths_count,
        );

        paths_count
    }
}