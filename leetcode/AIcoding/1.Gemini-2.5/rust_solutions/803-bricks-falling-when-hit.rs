struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            size: vec![1; n],
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            let root = self.find(self.parent[i]);
            self.parent[i] = root;
            root
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                self.parent[root_i] = root_j;
                self.size[root_j] += self.size[root_i];
            } else {
                self.parent[root_j] = root_i;
                self.size[root_i] += self.size[root_j];
            }
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn bricks_falling_when_hit(grid: Vec<Vec<i32>>, hits: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let num_nodes = m * n + 1; // +1 for the special ceiling node

        let mut grid_copy = grid.clone();
        let original_grid = grid; 

        // Mark all hit bricks as 0 in grid_copy
        for hit in &hits {
            let r = hit[0] as usize;
            let c = hit[1] as usize;
            if original_grid[r][c] == 1 { // Only mark if it was originally a brick
                grid_copy[r][c] = 0;
            }
        }

        let mut dsu = DSU::new(num_nodes);
        let ceiling_node_idx = m * n;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        // Build initial DSU from grid_copy (with all hits "applied")
        for r in 0..m {
            for c in 0..n {
                if grid_copy[r][c] == 1 {
                    let current_node_idx = r * n + c;

                    // Connect to ceiling if in row 0
                    if r == 0 {
                        dsu.union(current_node_idx, ceiling_node_idx);
                    }

                    // Connect to adjacent bricks
                    for i in 0..4 {
                        let nr = r as isize + dr[i];
                        let nc = c as isize + dc[i];

                        if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                            let nr = nr as usize;
                            let nc = nc as usize;
                            if grid_copy[nr][nc] == 1 {
                                dsu.union(current_node_idx, nr * n + nc);
                            }
                        }
                    }
                }
            }
        }

        let mut results = vec![0; hits.len()];

        // Process hits in reverse order
        for k in (0..hits.len()).rev() {
            let r = hits[k][0] as usize;
            let c = hits[k][1] as usize;

            // If the original brick was already 0, hitting it does nothing.
            if original_grid[r][c] == 0 {
                results[k] = 0;
                continue;
            }

            // Get the number of bricks connected to the ceiling BEFORE adding this brick back
            let prev_ceiling_connected_bricks = dsu.size[dsu.find(ceiling_node_idx)] - 1;

            // Add the brick back to grid_copy
            grid_copy[r][c] = 1;
            let current_node_idx = r * n + c;

            // Connect this brick to the ceiling if in row 0
            if r == 0 {
                dsu.union(current_node_idx, ceiling_node_idx);
            }

            // Connect this brick to its adjacent bricks (which are now in grid_copy)
            for i in 0..4 {
                let nr = r as isize + dr[i];
                let nc = c as isize + dc[i];

                if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;
                    if grid_copy[nr][nc] == 1 {
                        dsu.union(current_node_idx, nr * n + nc);
                    }
                }
            }

            // Get the number of bricks connected to the ceiling AFTER adding this brick back
            let curr_ceiling_connected_bricks = dsu.size[dsu.find(ceiling_node_idx)] - 1;

            // The number of fallen bricks is the difference, minus the brick itself that was re-added.
            // Use max(0, ...) to handle cases where no new bricks fell.
            results[k] = (curr_ceiling_connected_bricks - prev_ceiling_connected_bricks - 1).max(0) as i32;
        }

        results.reverse(); // Reverse to get the results in the original order of hits
        results
    }
}