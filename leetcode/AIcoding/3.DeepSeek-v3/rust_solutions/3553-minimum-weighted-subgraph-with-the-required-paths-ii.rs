use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_weight(n: i32, edges: Vec<Vec<i32>>, src1: i32, src2: i32, dest: i32) -> i64 {
        let n = n as usize;
        let src1 = src1 as usize;
        let src2 = src2 as usize;
        let dest = dest as usize;

        let mut graph = vec![vec![]; n];
        let mut reversed_graph = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i64;
            graph[u].push((v, w));
            reversed_graph[v].push((u, w));
        }

        let dijkstra = |start: usize, g: &Vec<Vec<(usize, i64)>>| -> Vec<i64> {
            let mut dist = vec![i64::MAX; n];
            dist[start] = 0;
            let mut heap = BinaryHeap::new();
            heap.push(Reverse((0, start)));

            while let Some(Reverse((d, u))) = heap.pop() {
                if d > dist[u] {
                    continue;
                }
                for &(v, w) in &g[u] {
                    if dist[v] > d + w {
                        dist[v] = d + w;
                        heap.push(Reverse((dist[v], v)));
                    }
                }
            }
            dist
        };

        let dist_src1 = dijkstra(src1, &graph);
        let dist_src2 = dijkstra(src2, &graph);
        let dist_dest = dijkstra(dest, &reversed_graph);

        let mut res = i64::MAX;
        for i in 0..n {
            if dist_src1[i] != i64::MAX && dist_src2[i] != i64::MAX && dist_dest[i] != i64::MAX {
                res = res.min(dist_src1[i] + dist_src2[i] + dist_dest[i]);
            }
        }

        if res == i64::MAX { -1 } else { res }
    }
}