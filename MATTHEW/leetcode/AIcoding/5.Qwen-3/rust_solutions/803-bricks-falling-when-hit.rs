```rust
mod solution {
    pub fn hit_bricks(grid: Vec<Vec<i32>>, hits: Vec<Vec<i32>>) -> Vec<i32> {
        use std::collections::{HashSet, VecDeque};

        let mut grid = grid;
        let rows = grid.len();
        let cols = if rows > 0 { grid[0].len() } else { 0 };

        // Apply all hits first
        for hit in &hits {
            let r = hit[0] as usize;
            let c = hit[1] as usize;
            if grid[r][c] == 1 {
                grid[r][c] = -1; // Mark as hit
            }
        }

        // Connect to top (union-find)
        let mut parent: Vec<usize> = (0..rows * cols + 1).collect();
        let mut size: Vec<usize> = vec![1; rows * cols + 1];

        // Find function with path compression
        fn find(parent: &mut Vec<usize>, x: usize) -> usize {
            if parent[x] != x {
                parent[x] = find(parent, parent[x]);
            }
            parent[x]
        }

        // Union function
        fn union(parent: &mut Vec<usize>, size: &mut Vec<usize>, x: usize, y: usize) {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x != root_y {
                if size[root_x] < size[root_y] {
                    parent[root_x] = root_y;
                    size[root_y] += size[root_x];
                } else {
                    parent[root_y] = root_x;
                    size[root_x] += size[root_y];
                }
            }
        }

        // Index for the ceiling
        let ceiling_idx = rows * cols;

        // Build union from bottom to top
        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == 1 {
                    let idx = r * cols + c;
                    if r == 0 {
                        union(&mut parent, &mut size, idx, ceiling_idx);
                    }
                    if r > 0 && grid[r - 1][c] == 1 {
                        let up_idx = (r - 1) * cols + c;
                        union(&mut parent, &mut size, idx, up_idx);
                    }
                    if c > 0 && grid[r][c - 1] == 1 {
                        let left_idx = r * cols + (c - 1);
                        union(&mut parent, &mut size, idx, left_idx);
                    }
                }
            }
        }

        // Process hits in reverse order
        let mut result = vec![0; hits.len()];
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        for (i, hit) in hits.iter().rev().enumerate() {
            let r = hit[0] as usize;
            let c = hit[1] as usize;

            if grid[r][c] == -1 {
                grid[r][c] = 1;

                let idx = r * cols + c;
                let init_size = size[find(&mut parent, ceiling_idx)];

                if r == 0 {
                    union(&mut parent, &mut size, idx, ceiling_idx);
                }

                for &(dr, dc) in &directions {
                    let nr = r as i32 + dr;
                    let nc = c as i32 + dc;
                    if nr >= 0 && nc >= 0 {
                        let nr = nr as usize;
                        let nc = nc as usize;
                        if nr < rows && nc < cols && grid[nr][nc] == 1 {
                            let neighbor_idx = nr * cols + nc;
                            union(&mut parent, &mut size, idx, neighbor_idx);
                        }
                    }
                }

                let new_size = size[find(&mut parent, ceiling_idx)];
                if new_size > init_size {
                    result[i] = (new_size - init_size) as i32;
                }
            }
        }

        result.into_iter().rev().collect()
    }
}