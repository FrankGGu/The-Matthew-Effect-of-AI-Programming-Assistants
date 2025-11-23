use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_weight(n: i32, edges: Vec<Vec<i32>>, src1: i32, src2: i32, dest: i32) -> i64 {
        let n = n as usize;
        let src1 = src1 as usize;
        let src2 = src2 as usize;
        let dest = dest as usize;

        let mut graph = vec![vec![]; n];
        let mut reverse_graph = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i64;
            graph[u].push((v, w));
            reverse_graph[v].push((u, w));
        }

        let dist_src1 = Self::dijkstra(src1, &graph, n);
        let dist_src2 = Self::dijkstra(src2, &graph, n);
        let dist_dest = Self::dijkstra(dest, &reverse_graph, n);

        let mut min_weight = i64::MAX;

        for i in 0..n {
            if dist_src1[i] != i64::MAX && dist_src2[i] != i64::MAX && dist_dest[i] != i64::MAX {
                min_weight = min_weight.min(dist_src1[i] + dist_src2[i] + dist_dest[i]);
            }
        }

        if min_weight == i64::MAX {
            -1
        } else {
            min_weight
        }
    }

    fn dijkstra(start: usize, graph: &Vec<Vec<(usize, i64)>>, n: usize) -> Vec<i64> {
        let mut dist = vec![i64::MAX; n];
        dist[start] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(Reverse((0, start)));

        while let Some(Reverse((d, u))) = heap.pop() {
            if d > dist[u] {
                continue;
            }
            for &(v, w) in &graph[u] {
                if dist[v] > dist[u] + w {
                    dist[v] = dist[u] + w;
                    heap.push(Reverse((dist[v], v)));
                }
            }
        }

        dist
    }
}