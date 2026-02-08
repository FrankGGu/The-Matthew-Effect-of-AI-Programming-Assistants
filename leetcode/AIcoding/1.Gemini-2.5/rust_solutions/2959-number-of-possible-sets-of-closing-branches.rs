struct Solution;

impl Solution {
    pub fn number_of_possible_sets(n: i32, roads: Vec<Vec<i32>>, max_distance: i32, k: i32) -> i32 {
        let n_usize = n as usize;
        let k_usize = k as usize;
        let mut count = 0;

        // Iterate through all possible subsets of branches to keep open.
        // A bitmask `mask` represents the set of open branches.
        for i in 0..(1 << n_usize) {
            let mut open_branches_indices = Vec::new();
            for j in 0..n_usize {
                if (i >> j) & 1 == 1 {
                    open_branches_indices.push(j);
                }
            }

            // Check if this subset has the correct number of open branches.
            // If `k` branches are closed, then `n - k` branches must be open.
            if open_branches_indices.len() != n_usize - k_usize {
                continue;
            }

            let num_open = open_branches_indices.len();
            if num_open == 0 {
                // If no branches are open, the max distance is 0.
                // This set is valid if 0 <= max_distance.
                if 0 <= max_distance {
                    count += 1;
                }
                continue;
            }

            // Create a distance matrix for the current set of open branches.
            // The indices in `current_dist` map to the original branch indices in `open_branches_indices`.
            let mut current_dist = vec![vec![i32::MAX; num_open]; num_open];

            // Initialize direct connections within the open branches.
            for p in 0..num_open {
                current_dist[p][p] = 0;
            }

            // Populate with direct roads between open branches.
            for road in &roads {
                let u_orig = road[0] as usize;
                let v_orig = road[1] as usize;
                let w = road[2];

                // Check if both u_orig and v_orig are in the current set of open branches.
                if let (Some(u_idx), Some(v_idx)) = (
                    open_branches_indices.iter().position(|&x| x == u_orig),
                    open_branches_indices.iter().position(|&x| x == v_orig),
                ) {
                    current_dist[u_idx][v_idx] = current_dist[u_idx][v_idx].min(w);
                    current_dist[v_idx][u_idx] = current_dist[v_idx][u_idx].min(w);
                }
            }

            // Run Floyd-Warshall on the current subgraph to find all-pairs shortest paths
            // among the open branches.
            for m in 0..num_open {
                for p in 0..num_open {
                    for q in 0..num_open {
                        if current_dist[p][m] != i32::MAX && current_dist[m][q] != i32::MAX {
                            current_dist[p][q] = current_dist[p][q].min(current_dist[p][m] + current_dist[m][q]);
                        }
                    }
                }
            }

            // Check the maximum shortest path distance among the open branches.
            let mut max_path_in_set = 0;
            let mut possible = true;
            for p in 0..num_open {
                for q in 0..num_open {
                    if current_dist[p][q] == i32::MAX {
                        // If any two open branches are disconnected, this set is invalid.
                        possible = false;
                        break;
                    }
                    max_path_in_set = max_path_in_set.max(current_dist[p][q]);
                }
                if !possible {
                    break;
                }
            }

            if possible && max_path_in_set <= max_distance {
                count += 1;
            }
        }

        count
    }
}