use std::collections::VecDeque;
use std::cmp::max;

impl Solution {
    pub fn divide_nodes_into_the_maximum_number_of_groups(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut max_overall_groups = 0;
        let mut visited_global = vec![false; n];

        for i in 0..n {
            if !visited_global[i] {
                let mut component_nodes = Vec::new(); // Collect nodes in current component
                let mut q_bfs = VecDeque::new(); // For BFS to find component, check bipartiteness, find farthest node

                let mut component_colors = vec![-1; n]; // -1: uncolored, 0: color A, 1: color B
                let mut component_dist = vec![-1; n]; // Distance from start node of component

                q_bfs.push_back(i);
                component_colors[i] = 0;
                component_dist[i] = 0;
                component_nodes.push(i); // Add start node to component_nodes

                let mut is_bipartite = true;
                let mut farthest_node_from_start = i;
                let mut max_dist_from_start = 0;

                let mut head = 0;
                while let Some(u) = q_bfs.pop_front() {
                    let d = component_dist[u];

                    if d > max_dist_from_start {
                        max_dist_from_start = d;
                        farthest_node_from_start = u;
                    }

                    for &v in &adj[u] {
                        if component_colors[v] == -1 { // Not visited in this component's BFS
                            component_colors[v] = 1 - component_colors[u];
                            component_dist[v] = d + 1;
                            q_bfs.push_back(v);
                            component_nodes.push(v); // Add to component_nodes
                        } else if component_colors[v] == component_colors[u] { // Odd cycle detected
                            is_bipartite = false;
                            break;
                        }
                    }
                    if !is_bipartite { break; }
                }

                if !is_bipartite {
                    return 0; // Impossible to satisfy conditions
                }

                // Mark all nodes in this component as globally visited
                for &node in &component_nodes {
                    visited_global[node] = true;
                }

                // Find diameter of this bipartite component
                // BFS from farthest_node_from_start (found in the first BFS)
                let mut q_diameter = VecDeque::new();
                q_diameter.push_back((farthest_node_from_start, 0)); // (node, distance)
                let mut diameter_visited = vec![false; n]; // Reset visited for diameter BFS
                diameter_visited[farthest_node_from_start] = true;

                let mut current_diameter = 0;

                while let Some((u, d)) = q_diameter.pop_front() {
                    current_diameter = d; // This will hold the maximum distance reached in this BFS
                    for &v in &adj[u] {
                        if !diameter_visited[v] {
                            diameter_visited[v] = true;
                            q_diameter.push_back((v, d + 1));
                        }
                    }
                }
                max_overall_groups = max(max_overall_groups, current_diameter + 1);
            }
        }

        max_overall_groups
    }
}