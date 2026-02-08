use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq, Copy, Clone)]
struct State {
    moves: i32,
    node: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        // We want a min-heap, so we compare by moves in reverse order.
        // If moves are equal, node ID can be used for stable ordering, but not strictly necessary here.
        other.moves.cmp(&self.moves)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn reachable_nodes(edges: Vec<Vec<i32>>, n: i32, max_moves: i32) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n_usize];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let cnt = edge[2];
            adj[u].push((v, cnt));
            adj[v].push((u, cnt));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; n_usize];
        let mut pq: BinaryHeap<State> = BinaryHeap::new();

        dist[0] = 0;
        pq.push(State { moves: 0, node: 0 });

        while let Some(State { moves, node }) = pq.pop() {
            if moves > dist[node] {
                continue;
            }

            for &(neighbor, cnt) in &adj[node] {
                let weight = cnt + 1; // Total length of the edge including subdivisions

                // Check for potential overflow before addition, though with i32::MAX and positive weight
                // `moves + weight` would not exceed i32::MAX if `moves` is already i32::MAX and `weight` is positive.
                // The `dist[node] != i32::MAX` check ensures we only extend from reachable nodes.
                if dist[node] != i32::MAX && moves + weight < dist[neighbor] {
                    dist[neighbor] = moves + weight;
                    pq.push(State { moves: dist[neighbor], node: neighbor });
                }
            }
        }

        let mut total_reachable_nodes = 0;

        // Count original nodes reachable
        for i in 0..n_usize {
            if dist[i] <= max_moves {
                total_reachable_nodes += 1;
            }
        }

        // Count subdivided nodes reachable
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let cnt = edge[2];

            let reachable_from_u = if dist[u] <= max_moves {
                max_moves - dist[u]
            } else {
                0
            };

            let reachable_from_v = if dist[v] <= max_moves {
                max_moves - dist[v]
            } else {
                0
            };

            // The number of subdivided nodes on this edge that can be reached
            // is the minimum of `cnt` (total subdivisions on this edge)
            // and the sum of moves available from both ends.
            total_reachable_nodes += cnt.min(reachable_from_u + reachable_from_v);
        }

        total_reachable_nodes
    }
}