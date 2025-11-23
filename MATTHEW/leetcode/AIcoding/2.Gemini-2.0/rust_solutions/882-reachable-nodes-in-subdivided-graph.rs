use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn reachable_nodes(edges: Vec<Vec<i32>>, max_moves: i32, n: i32) -> i32 {
        let mut adj: Vec<Vec<(i32, i32)>> = vec![vec![]; n as usize];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v as i32, w));
            adj[v].push((u as i32, w));
        }

        let mut dist: Vec<i32> = vec![i32::max_value(); n as usize];
        dist[0] = 0;

        let mut pq: BinaryHeap<(Reverse<i32>, i32)> = BinaryHeap::new();
        pq.push((Reverse(0), 0));

        let mut visited: Vec<i32> = vec![0; edges.len()];
        let mut edge_index: std::collections::HashMap<(i32, i32), usize> = std::collections::HashMap::new();
        for (i, edge) in edges.iter().enumerate() {
            edge_index.insert((edge[0], edge[1]), i);
            edge_index.insert((edge[1], edge[0]), i);
        }

        let mut ans = 0;

        while let Some((Reverse(d), u)) = pq.pop() {
            if d > dist[u as usize] {
                continue;
            }

            ans += 1;

            for &(v, w) in &adj[u as usize] {
                if dist[v as usize] > dist[u as usize] + w + 1 {
                    dist[v as usize] = dist[u as usize] + w + 1;
                    pq.push((Reverse(dist[v as usize]), v));
                }

                let edge_id = edge_index.get(&(u, v)).unwrap();

                let moves_u = max_moves - dist[u as usize];
                let moves_v = max_moves - dist[v as usize];

                let reachable_on_edge = std::cmp::max(0, std::cmp::min(moves_u, w));
                let reachable_on_edge2 = std::cmp::max(0, std::cmp::min(moves_v, w - reachable_on_edge));

                visited[*edge_id] += reachable_on_edge + reachable_on_edge2;
            }
        }

        for count in visited {
            ans += std::cmp::min(count, edges[count as usize].get(2).copied().unwrap());
        }

        ans
    }
}