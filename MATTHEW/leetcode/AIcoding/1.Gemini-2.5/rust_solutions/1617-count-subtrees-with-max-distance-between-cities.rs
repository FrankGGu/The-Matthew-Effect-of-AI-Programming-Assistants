use std::collections::{VecDeque, HashSet};
use std::cmp::max;

impl Solution {
    pub fn count_subgraphs_for_each_diameter(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n_usize = n as usize;

        // 1. Build adjacency list for the original graph
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = (edge[0] - 1) as usize;
            let v = (edge[1] - 1) as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        // 2. Pre-compute all-pairs shortest paths `dist[i][j]` using BFS
        let mut dist: Vec<Vec<i32>> = vec![vec![-1; n_usize]; n_usize];
        for i in 0..n_usize {
            let mut q: VecDeque<usize> = VecDeque::new();
            q.push_back(i);
            dist[i][i] = 0;

            while let Some(u) = q.pop_front() {
                for &v in &adj[u] {
                    if dist[i][v] == -1 { // If not visited yet
                        dist[i][v] = dist[i][u] + 1;
                        q.push_back(v);
                    }
                }
            }
        }

        // 3. Initialize `ans` array. ans[d] stores count for max distance d.
        // The maximum possible distance in a tree with n nodes is n-1.
        // We use size n to store counts for distances 0 to n-1.
        let mut ans: Vec<i32> = vec![0; n_usize]; 

        // 4. Iterate through all non-empty subsets of cities
        // A subset is represented by a bitmask.
        // (1 << n_usize) - 1 is the mask for all cities.
        for mask in 1..(1 << n_usize) {
            let mut cities_in_subset: Vec<usize> = Vec::new();
            for i in 0..n_usize {
                if (mask >> i) & 1 == 1 {
                    cities_in_subset.push(i);
                }
            }

            let k = cities_in_subset.len();

            // Subtree must have at least two cities to have a positive diameter.
            // But we still need to check connectivity for k=1 to ensure the logic is sound,
            // even though they will be skipped by max_dist_in_subtree > 0 check.
            if k == 0 { continue; } // Should not happen with mask starting from 1

            let mut num_edges_in_subset = 0;
            let first_node_in_subset = cities_in_subset[0];

            // Count edges where both endpoints are in the current subset
            for &u in &cities_in_subset {
                for &v in &adj[u] {
                    // Check if v is also in the subset
                    if (mask >> v) & 1 == 1 {
                        // Only count each edge once (e.g., u < v)
                        if u < v { 
                            num_edges_in_subset += 1;
                        }
                    }
                }
            }

            // A connected graph with k nodes is a tree if it has k-1 edges.
            // If it has fewer, it's disconnected. If more, it has cycles.
            if num_edges_in_subset != k as i32 - 1 {
                continue; 
            }

            // Verify connectivity using BFS/DFS starting from an arbitrary node in the subset
            let mut visited_count = 0;
            let mut q_bfs: VecDeque<usize> = VecDeque::new();
            let mut visited: Vec<bool> = vec![false; n_usize]; // Tracks visited nodes in current BFS

            q_bfs.push_back(first_node_in_subset);
            visited[first_node_in_subset] = true;
            visited_count += 1;

            while let Some(u) = q_bfs.pop_front() {
                for &v in &adj[u] {
                    // Check if v is in the current subset AND not visited yet in this BFS
                    if (mask >> v) & 1 == 1 && !visited[v] {
                        visited[v] = true;
                        visited_count += 1;
                        q_bfs.push_back(v);
                    }
                }
            }

            // If not all cities in the subset were reachable, it's not a single connected component
            if visited_count != k {
                continue;
            }

            // If we reached here, it's a valid connected subtree.
            // Calculate its diameter (max distance between any two cities in the subtree)
            let mut max_dist_in_subtree = 0;
            for i in 0..k {
                for j in (i + 1)..k {
                    let u = cities_in_subset[i];
                    let v = cities_in_subset[j];
                    max_dist_in_subtree = max(max_dist_in_subtree, dist[u][v]);
                }
            }

            // Increment count for this diameter, if it's positive (as per problem constraints d >= 1)
            if max_dist_in_subtree > 0 {
                ans[max_dist_in_subtree as usize] += 1;
            }
        }

        // Return ans[1..n] as per problem statement (d ranges from 1 to n-1)
        ans.into_iter().skip(1).collect()
    }
}