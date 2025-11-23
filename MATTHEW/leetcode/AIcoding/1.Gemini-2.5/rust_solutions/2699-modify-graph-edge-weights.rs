use std::collections::{BinaryHeap};
use std::cmp::Ordering;

#[derive(Eq, PartialEq, Copy, Clone)]
struct State {
    cost: i32,
    position: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        // Negate the cost to make it a min-heap
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

fn dijkstra_with_edges(n: usize, edges: &Vec<Vec<i32>>, source: usize, destination: usize) -> i32 {
    let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];
    for edge in edges {
        let u = edge[0] as usize;
        let v = edge[1] as usize;
        let w = edge[2];

        // If an edge weight is -1, it means it's not yet assigned, or it's part of the original problem setup.
        // For Dijkstra, we assume all weights are positive. If we encounter a -1 here, it's an error in logic
        // because `ans_edges` should have all -1s replaced by 1 or `1 + diff`.
        // However, the problem statement implies edge weights are positive integers or -1.
        // If w is -1, it means it's one of the edges we haven't modified yet in the loop.
        // It should not happen if `ans_edges` is correctly prepared.
        // Let's ensure w is treated as positive for Dijkstra.
        // The problem ensures positive weights for non -1 edges.
        // Our modification sets -1 to 1 or 1+diff, so all weights will be positive.

        adj[u].push((v, w));
        adj[v].push((u, w));
    }

    let mut dist: Vec<i32> = vec![i32::MAX; n];
    let mut heap = BinaryHeap::new();

    dist[source] = 0;
    heap.push(State { cost: 0, position: source });

    while let Some(State { cost, position }) = heap.pop() {
        if cost > dist[position] {
            continue;
        }

        if position == destination {
            return cost;
        }

        for &(neighbor, weight) in &adj[position] {
            // Check for overflow before addition
            // dist[position] can be i32::MAX, weight can be positive.
            // If dist[position] is i32::MAX, it means not reachable yet or overflowed.
            // Only proceed if dist[position] is a valid (finite) distance.
            if dist[position] != i32::MAX {
                if let Some(new_cost) = dist[position].checked_add(weight) {
                    if new_cost < dist[neighbor] {
                        dist[neighbor] = new_cost;
                        heap.push(State { cost: new_cost, position: neighbor });
                    }
                } else {
                    // Overflow occurred, treat as infinite path
                    // This path won't be shorter than any existing valid path, so do nothing.
                }
            }
        }
    }
    dist[destination] // Will be i32::MAX if not reachable
}

impl Solution {
    pub fn modify_graph_edge_weights(n: i32, edges: Vec<Vec<i32>>, source: i32, destination: i32, target: i32) -> Vec<Vec<i32>> {
        let n_usize = n as usize;
        let source_usize = source as usize;
        let destination_usize = destination as usize;

        let mut minus_one_indices: Vec<usize> = Vec::new();

        // Create a mutable copy of edges for the answer
        let mut ans_edges = edges.clone();

        for i in 0..ans_edges.len() {
            if ans_edges[i][2] == -1 {
                minus_one_indices.push(i);
                ans_edges[i][2] = 1; // Temporarily set to 1 for initial Dijkstra
            }
        }

        // Phase 1: Calculate shortest path with all -1 edges set to 1.
        let dist_min_path_len = dijkstra_with_edges(n_usize, &ans_edges, source_usize, destination_usize);

        if dist_min_path_len < target {
            // The shortest path is too short. We need to increase weights of some -1 edges.
            // The total increase needed is `target - dist_min_path_len`.
            // We try to distribute this entire increase to one of the -1 edges.
            let diff_to_add = target - dist_min_path_len;
            let mut found_one_edge_to_modify = false;

            for &idx in &minus_one_indices {
                // Try to make this edge absorb the entire `diff_to_add`.
                // Its current value is 1 (from initial setup).
                ans_edges[idx][2] = 1 + diff_to_add;

                let current_path_len = dijkstra_with_edges(n_usize, &ans_edges, source_usize, destination_usize);

                if current_path_len == target {
                    // Found a solution by modifying this edge.
                    // All other -1 edges that were processed before `idx` were reset to 1.
                    // All -1 edges that come after `idx` are still 1 (from initial setup).
                    found_one_edge_to_modify = true;
                    break; // Exit loop, `ans_edges` now has the correct weight for `idx`
                } else {
                    // This modification didn't result in target length. Reset this edge to 1.
                    ans_edges[idx][2] = 1;
                }
            }

            if found_one_edge_to_modify {
                // If a solution was found, `ans_edges` is already in the correct state.
                // All -1 edges before the modified one are 1, the modified one has `1 + diff_to_add`,
                // and all -1 edges after the modified one are 1 (from initial setup).
                return ans_edges;
            } else {
                // No single -1 edge could be modified to achieve the target length.
                return vec![];
            }
        } else if dist_min_path_len == target {
            // Path is already target length with all -1 edges as 1.
            // `ans_edges` is already in the correct state (all -1s are 1).
            return ans_edges;
        } else { // dist_min_path_len > target
            // Even with all -1 edges set to 1, the shortest path is longer than target. Impossible.
            return vec![];
        }
    }
}