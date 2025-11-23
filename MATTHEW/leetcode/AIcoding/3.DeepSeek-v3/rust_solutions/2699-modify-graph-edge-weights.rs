use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn modified_graph_edges(n: i32, edges: Vec<Vec<i32>>, source: i32, destination: i32, target: i32) -> Vec<Vec<i32>> {
        let n = n as usize;
        let source = source as usize;
        let destination = destination as usize;
        let target = target as i64;

        let mut adj = vec![vec![]; n];
        for (i, edge) in edges.iter().enumerate() {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, i, w));
            adj[v].push((u, i, w));
        }

        let mut dist = vec![i64::MAX; n];
        dist[source] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(Reverse((0, source)));

        while let Some(Reverse((d, u))) = heap.pop() {
            if u == destination {
                break;
            }
            if d > dist[u] {
                continue;
            }
            for &(v, _, w) in &adj[u] {
                let new_d = d + if w == -1 { 1 } else { w as i64 };
                if new_d < dist[v] {
                    dist[v] = new_d;
                    heap.push(Reverse((new_d, v)));
                }
            }
        }

        if dist[destination] > target {
            return vec![];
        }

        let mut edges = edges;
        let mut found = false;

        let mut dist2 = vec![i64::MAX; n];
        dist2[source] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(Reverse((0, source)));

        while let Some(Reverse((d, u))) = heap.pop() {
            if u == destination {
                if d == target {
                    found = true;
                }
                break;
            }
            if d > dist2[u] {
                continue;
            }
            for &(v, i, w) in &adj[u] {
                let mut new_d = d;
                if w == -1 {
                    if dist[v] + d < target {
                        new_d += (target - dist[v] - d) as i64;
                        edges[i][2] = (target - dist[v] - d) as i32;
                    } else {
                        new_d += 1;
                        edges[i][2] = 1;
                    }
                } else {
                    new_d += w as i64;
                }
                if new_d < dist2[v] {
                    dist2[v] = new_d;
                    heap.push(Reverse((new_d, v)));
                }
            }
        }

        if !found {
            return vec![];
        }

        for edge in &mut edges {
            if edge[2] == -1 {
                edge[2] = 1;
            }
        }

        edges
    }
}