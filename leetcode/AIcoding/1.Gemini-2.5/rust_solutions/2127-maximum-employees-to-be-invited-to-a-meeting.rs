use std::collections::{HashSet, VecDeque};
use std::cmp::max;

impl Solution {
    pub fn maximum_invitations(favorite: Vec<i32>) -> i32 {
        let n = favorite.len();
        let favorite_usize: Vec<usize> = favorite.iter().map(|&x| x as usize).collect();

        // Step 1: Build reverse adjacency list
        let mut rev_adj: Vec<Vec<usize>> = vec![vec![]; n];
        for i in 0..n {
            rev_adj[favorite_usize[i]].push(i);
        }

        // Step 2: Find all cycles and mark cycle nodes
        // color: 0=white (unvisited), 1=gray (visiting), 2=black (visited)
        let mut color: Vec<i8> = vec![0; n];
        let mut path_len_from_start_of_dfs: Vec<usize> = vec![0; n];
        let mut max_overall_cycle_len = 0;
        let mut is_in_any_cycle: Vec<bool> = vec![false; n];
        let mut two_cycle_pairs: Vec<(usize, usize)> = Vec::new();

        // Helper function for recursive DFS to find cycles
        fn dfs_find_cycles(
            u: usize,
            current_path_len: usize,
            favorite_usize: &Vec<usize>,
            color: &mut Vec<i8>,
            path_len_from_start_of_dfs: &mut Vec<usize>,
            max_overall_cycle_len: &mut usize,
            is_in_any_cycle: &mut Vec<bool>,
            two_cycle_pairs: &mut Vec<(usize, usize)>,
        ) {
            color[u] = 1; // Mark as gray (visiting)
            path_len_from_start_of_dfs[u] = current_path_len;

            let v = favorite_usize[u];
            if color[v] == 0 { // Not visited
                dfs_find_cycles(
                    v,
                    current_path_len + 1,
                    favorite_usize,
                    color,
                    path_len_from_start_of_dfs,
                    max_overall_cycle_len,
                    is_in_any_cycle,
                    two_cycle_pairs,
                );
            } else if color[v] == 1 { // Gray, means `v` is an ancestor in current DFS path, so cycle found
                let cycle_len = current_path_len - path_len_from_start_of_dfs[v] + 1;
                *max_overall_cycle_len = max(*max_overall_cycle_len, cycle_len);

                if cycle_len == 2 {
                    two_cycle_pairs.push((u, v));
                }

                // Mark all nodes in this cycle as `is_in_any_cycle`
                let mut curr = u;
                while curr != v {
                    is_in_any_cycle[curr] = true;
                    curr = favorite_usize[curr];
                }
                is_in_any_cycle[v] = true;
            }
            // If color[v] == 2 (black), it means v is already visited and processed.
            // This path leads to an already processed component, not a cycle in current path.

            color[u] = 2; // Mark as black (visited)
        }

        for i in 0..n {
            if color[i] == 0 {
                dfs_find_cycles(
                    i,
                    0,
                    &favorite_usize,
                    &mut color,
                    &mut path_len_from_start_of_dfs,
                    &mut max_overall_cycle_len,
                    &mut is_in_any_cycle,
                    &mut two_cycle_pairs,
                );
            }
        }

        // Step 3: Calculate sum of chain lengths for 2-cycles
        let mut total_2_cycle_chains_len = 0;
        let mut memo_chain_len: Vec<i32> = vec![-1; n]; // Memoization for dfs_get_max_chain_len

        // Helper function for calculating max chain length
        // This calculates the maximum number of *additional* nodes that can be attached to `u`
        // from its "tree" part, where these additional nodes are not part of any cycle.
        fn dfs_get_max_chain_len(
            u: usize,
            rev_adj: &Vec<Vec<usize>>,
            is_in_any_cycle: &Vec<bool>,
            memo_chain_len: &mut Vec<i32>,
        ) -> i32 {
            if memo_chain_len[u] != -1 {
                return memo_chain_len[u];
            }

            let mut max_len = 0;
            for &prev_node in &rev_adj[u] {
                // Only consider nodes that are not part of any cycle.
                // If prev_node is part of ANY cycle, it cannot be part of a chain leading to a 2-cycle.
                if !is_in_any_cycle[prev_node] {
                    max_len = max(max_len, 1 + dfs_get_max_chain_len(prev_node, rev_adj, is_in_any_cycle, memo_chain_len));
                }
            }
            memo_chain_len[u] = max_len;
            max_len
        }

        let mut processed_2_cycle_nodes: HashSet<usize> = HashSet::new();

        for &(u, v) in &two_cycle_pairs {
            // Ensure we only process each 2-cycle once
            if !processed_2_cycle_nodes.contains(&u) {
                processed_2_cycle_nodes.insert(u);
                processed_2_cycle_nodes.insert(v);

                let chain_len_u = dfs_get_max_chain_len(u, &rev_adj, &is_in_any_cycle, &mut memo_chain_len);
                let chain_len_v = dfs_get_max_chain_len(v, &rev_adj, &is_in_any_cycle, &mut memo_chain_len);

                // The 2 nodes in the cycle (u, v) + their attached chains
                total_2_cycle_chains_len += 2 + chain_len_u + chain_len_v;
            }
        }

        max(max_overall_cycle_len as i32, total_2_cycle_chains_len)
    }
}