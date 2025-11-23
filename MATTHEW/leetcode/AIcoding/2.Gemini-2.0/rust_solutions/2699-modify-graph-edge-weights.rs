use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn modified_graph_edges(n: i32, edges: Vec<Vec<i32>>, source: i32, destination: i32, target: i32) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32, usize)>> = vec![vec![]; n];
        let mut unknown_edges: Vec<usize> = vec![];

        for (i, edge) in edges.iter().enumerate() {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];

            adj[u].push((v, w, i));
            adj[v].push((u, w, i));

            if w == -1 {
                unknown_edges.push(i);
            }
        }

        let mut modified_edges = edges.clone();

        fn dijkstra(adj: &Vec<Vec<(usize, i32, usize)>>, start: usize, end: usize, n: usize) -> i64 {
            let mut dist: Vec<i64> = vec![i64::MAX; n];
            dist[start] = 0;
            let mut pq: BinaryHeap<(Reverse<i64>, usize)> = BinaryHeap::new();
            pq.push((Reverse(0), start));

            while let Some((Reverse(d), u)) = pq.pop() {
                if d > dist[u] {
                    continue;
                }

                for &(v, w, _) in &adj[u] {
                    let weight = w as i64;
                    if dist[u] + weight < dist[v] {
                        dist[v] = dist[u] + weight;
                        pq.push((Reverse(dist[v]), v));
                    }
                }
            }

            if dist[end] == i64::MAX {
                -1
            } else {
                dist[end]
            }
        }

        let mut low = 0;
        let mut high = 2001;

        while low < high {
            let mid = low + (high - low) / 2;

            let mut temp_adj: Vec<Vec<(usize, i32, usize)>> = vec![vec![]; n];

            for (i, edge) in edges.iter().enumerate() {
                let u = edge[0] as usize;
                let v = edge[1] as usize;
                let mut w = edge[2];
                if w == -1 {
                    w = mid;
                }

                temp_adj[u].push((v, w, i));
                temp_adj[v].push((u, w, i));
            }

            let shortest_path = dijkstra(&temp_adj, source as usize, destination as usize, n);

            if shortest_path == -1 || shortest_path > target as i64 {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        let final_value = low;

        let mut temp_adj: Vec<Vec<(usize, i32, usize)>> = vec![vec![]; n];

        for (i, edge) in edges.iter().enumerate() {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let mut w = edge[2];
            if w == -1 {
                w = final_value;
            }

            temp_adj[u].push((v, w, i));
            temp_adj[v].push((u, w, i));
        }

        let shortest_path = dijkstra(&temp_adj, source as usize, destination as usize, n);

        if shortest_path != target as i64 {
            return vec![];
        }

        for (i, edge) in modified_edges.iter_mut().enumerate() {
            if edge[2] == -1 {
                edge[2] = final_value;
            }
        }

        modified_edges
    }
}