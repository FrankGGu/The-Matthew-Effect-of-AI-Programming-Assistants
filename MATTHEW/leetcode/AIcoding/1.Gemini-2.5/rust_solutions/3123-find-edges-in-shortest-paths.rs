use std::collections::BinaryHeap;
use std::cmp::Reverse;

const INF: i64 = std::i64::MAX;

fn dijkstra(start_node: usize, n: usize, adj: &Vec<Vec<(usize, i32)>>) -> Vec<i64> {
    let mut dist = vec![INF; n];
    let mut pq = BinaryHeap::new();

    dist[start_node] = 0;
    pq.push(Reverse((0, start_node))); // (distance, node)

    while let Some(Reverse((d, u))) = pq.pop() {
        if d > dist[u] {
            continue;
        }

        for &(v, weight) in &adj[u] {
            let new_dist = d + weight as i64;
            if new_dist < dist[v] {
                dist[v] = new_dist;
                pq.push(Reverse((new_dist, v)));
            }
        }
    }
    dist
}

impl Solution {
    pub fn find_all_shortest_paths(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n_usize];
        let mut rev_adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n_usize];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            rev_adj[v].push((u, w));
        }

        let dist_from_src = dijkstra(0, n_usize, &adj);
        let dist_to_dest = dijkstra(n_usize - 1, n_usize, &rev_adj);

        let total_shortest_path_len = dist_from_src[n_usize - 1];

        if total_shortest_path_len == INF {
            return vec![];
        }

        let mut result_indices = Vec::new();
        for (i, edge) in edges.iter().enumerate() {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];

            if dist_from_src[u] != INF && dist_to_dest[v] != INF && 
               dist_from_src[u] + w as i64 + dist_to_dest[v] == total_shortest_path_len {
                result_indices.push(i as i32);
            }
        }

        result_indices
    }
}