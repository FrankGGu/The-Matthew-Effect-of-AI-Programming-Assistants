use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn is_printable(target_grid: Vec<Vec<i32>>) -> bool {
        let m = target_grid.len();
        let n = target_grid[0].len();

        // Step 1: Find bounding box for each color and identify all present colors.
        // Max color value is 60. Use arrays of size 61 for convenience (index 0 unused).
        let mut min_r = vec![m; 61];
        let mut max_r = vec![0; 61];
        let mut min_c = vec![n; 61];
        let mut max_c = vec![0; 61];
        let mut colors_present = HashSet::new();

        for r in 0..m {
            for c in 0..n {
                let color = target_grid[r][c] as usize;
                colors_present.insert(color);
                min_r[color] = min_r[color].min(r);
                max_r[color] = max_r[color].max(r);
                min_c[color] = min_c[color].min(c);
                max_c[color] = max_c[color].max(c);
            }
        }

        // Step 2: Build dependency graph (adjacency list and in-degrees).
        // An edge `u -> v` means color `u` must be painted before color `v`.
        // We use `HashSet` for `adj` to automatically handle unique edges and provide O(1) average insertion.
        let mut adj: Vec<HashSet<usize>> = vec![HashSet::new(); 61];
        let mut in_degree: Vec<i32> = vec![0; 61];

        for &color_outer_val in &colors_present {
            let color_outer = color_outer_val as usize;
            // Iterate through all cells within the bounding box of `color_outer`.
            for r in min_r[color_outer]..=max_r[color_outer] {
                for c in min_c[color_outer]..=max_c[color_outer] {
                    let color_at_cell = target_grid[r][c] as usize;
                    // If a cell within `color_outer`'s bounding box contains a different color,
                    // that `color_at_cell` must have been painted *after* `color_outer`
                    // to overwrite `color_outer` at this specific cell.
                    // Thus, `color_outer` must be painted before `color_at_cell`.
                    if color_at_cell != color_outer {
                        // If `adj[color_outer].insert(color_at_cell)` returns true, it means the edge is new.
                        if adj[color_outer].insert(color_at_cell) {
                            in_degree[color_at_cell] += 1;
                        }
                    }
                }
            }
        }

        // Step 3: Perform topological sort using Kahn's algorithm.
        let mut q = VecDeque::new();
        for &color_val in &colors_present {
            let color = color_val as usize;
            if in_degree[color] == 0 {
                q.push_back(color);
            }
        }

        let mut processed_colors_count = 0;
        while let Some(u) = q.pop_front() {
            processed_colors_count += 1;
            // For each neighbor `v` of `u` (i.e., `u -> v`):
            for &v in &adj[u] {
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    q.push_back(v);
                }
            }
        }

        // If the number of processed colors equals the total number of distinct colors present,
        // it means a valid topological sort was found (no cycles), and the grid is formable.
        processed_colors_count == colors_present.len()
    }
}