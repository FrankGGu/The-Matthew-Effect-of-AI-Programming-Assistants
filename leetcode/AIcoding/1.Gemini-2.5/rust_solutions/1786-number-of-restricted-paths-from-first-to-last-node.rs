use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn count_restricted_paths(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize - 1; // 0-indexed
            let v = edge[1] as usize - 1; // 0-indexed
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        // Step 1: Calculate shortest distances from node n (n_usize - 1) to all other nodes using Dijkstra
        let mut dist: Vec<i32> = vec![i32::MAX; n_usize];
        let mut pq: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();

        dist[n_usize - 1] = 0; // Shortest distance from n to n is 0
        pq.push(Reverse((0, n_usize - 1)));

        while let Some(Reverse((d, u))) = pq.pop() {
            if d > dist[u] {
                continue;
            }

            for &(v, weight) in &adj[u] {
                // Prevent overflow: check if dist[u] is not MAX before adding weight
                if dist[u] != i32::MAX && dist[u] + weight < dist[v] {
                    dist[v] = dist[u] + weight;
                    pq.push(Reverse((dist[v], v)));
                }
            }
        }

        // Step 2: Dynamic Programming to count restricted paths
        let MOD: i32 = 1_000_000_007;
        let mut dp: Vec<i32> = vec![0; n_usize];
        dp[n_usize - 1] = 1; // There is one restricted path from node n to node n (the node itself)

        // Create a list of nodes with their calculated distances
        let mut nodes_with_dist: Vec<(i32, usize)> = Vec::with_capacity(n_usize);
        for i in 0..n_usize {
            nodes_with_dist.push((dist[i], i));
        }

        // Sort nodes by their distance to node n in ascending order
        // This ensures that when we calculate dp[u], dp[v] for all v with dist[v] < dist[u] are already computed.
        nodes_with_dist.sort_unstable(); 

        for (current_dist, u) in nodes_with_dist {
            // If current_dist is i32::MAX, it means node u is unreachable from node n.
            // In this case, dp[u] should remain 0, which is its initial value.
            // The loop will still proceed, but the condition `current_dist > dist[v]` will never be met
            // for any valid dist[v] (which would be < i32::MAX).

            for &(v, _) in &adj[u] {
                // A path is restricted if for every consecutive pair of nodes (u, v) in the path, dist[u] > dist[v].
                if current_dist > dist[v] {
                    dp[u] = (dp[u] + dp[v]) % MOD;
                }
            }
        }

        dp[0] // Return the number of restricted paths from node 1 (0-indexed)
    }
}