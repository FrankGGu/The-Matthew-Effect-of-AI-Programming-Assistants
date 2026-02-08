use std::collections::{HashMap, HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn largest_island(mut grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 0 {
            return 0;
        }

        let mut island_id_counter = 2; // 0 for water, 1 for land, >=2 for identified islands
        let mut island_sizes: HashMap<i32, i32> = HashMap::new();
        let mut max_overall_size = 0;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        let is_valid = |r: i32, c: i32| -> bool {
            r >= 0 && r < n as i32 && c >= 0 && c < n as i32
        };

        // First Pass: Identify existing islands and their sizes using BFS
        for r_idx in 0..n {
            for c_idx in 0..n {
                if grid[r_idx][c_idx] == 1 {
                    let mut current_island_size = 0;
                    let mut q: VecDeque<(i32, i32)> = VecDeque::new();
                    q.push_back((r_idx as i32, c_idx as i32));
                    grid[r_idx][c_idx] = island_id_counter; // Mark as visited with current island_id

                    while let Some((r, c)) = q.pop_front() {
                        current_island_size += 1;

                        for i in 0..4 {
                            let nr = r + dr[i];
                            let nc = c + dc[i];

                            if is_valid(nr, nc) && grid[nr as usize][nc as usize] == 1 {
                                grid[nr as usize][nc as usize] = island_id_counter;
                                q.push_back((nr, nc));
                            }
                        }
                    }
                    island_sizes.insert(island_id_counter, current_island_size);
                    max_overall_size = max_overall_size.max(current_island_size);
                    island_id_counter += 1;
                }
            }
        }

        let mut found_zero = false;

        // Second Pass: Try flipping each '0' to '1'
        for r_idx in 0..n {
            for c_idx in 0..n {
                if grid[r_idx][c_idx] == 0 {
                    found_zero = true;
                    let mut current_potential_size = 1; // For the flipped '0' itself
                    let mut seen_neighbor_islands: HashSet<i32> = HashSet::new();

                    for i in 0..4 {
                        let nr = r_idx as i32 + dr[i];
                        let nc = c_idx as i32 + dc[i];

                        if is_valid(nr, nc) {
                            let neighbor_val = grid[nr as usize][nc as usize];
                            if neighbor_val > 1 { // It's an identified island
                                if seen_neighbor_islands.insert(neighbor_val) { // Only add size once per unique island
                                    current_potential_size += island_sizes[&neighbor_val];
                                }
                            }
                        }
                    }
                    max_overall_size = max_overall_size.max(current_potential_size);
                }
            }
        }

        // If no '0's were found, it means the grid was all '1's (or empty).
        // In this case, max_overall_size would have been set to n*n in the first pass.
        // If the grid was all '0's, `found_zero` would be true, and `max_overall_size`
        // would be updated to 1 by flipping one '0'.
        max_overall_size
    }
}