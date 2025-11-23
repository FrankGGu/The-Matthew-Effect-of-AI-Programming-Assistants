impl Solution {

use std::collections::{BinaryHeap, HashMap};

impl Solution {
    pub fn modify_graph(n: i32, edges: Vec<Vec<i32>>, source: i32, dest: i32, target: i32) -> Vec<Vec<i32>> {
        let n = n as usize;
        let source = source as usize;
        let dest = dest as usize;

        let mut graph = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            graph[u].push((v, w));
            graph[v].push((u, w));
        }

        let dist = dijkstra(&graph, source);
        if dist[dest] > target {
            return vec![];
        }

        let mut new_edges = edges.clone();
        for edge in &mut new_edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            if edge[2] == -1 {
                edge[2] = target - dist[dest] + 1;
                graph[u].push((v, edge[2]));
                graph[v].push((u, edge[2]));
            }
        }

        let dist2 = dijkstra(&graph, source);
        if dist2[dest] != target {
            return vec![];
        }

        new_edges
    }
}

fn dijkstra(graph: &Vec<Vec<(usize, i32)>>, start: usize) -> Vec<i32> {
    let n = graph.len();
    let mut dist = vec![i32::MAX; n];
    dist[start] = 0;
    let mut heap = BinaryHeap::new();
    heap.push((0, start));

    while let Some((d, u)) = heap.pop() {
        if d > dist[u] {
            continue;
        }
        for &(v, w) in &graph[u] {
            if dist[v] > d + w {
                dist[v] = d + w;
                heap.push((dist[v], v));
            }
        }
    }

    dist
}
}