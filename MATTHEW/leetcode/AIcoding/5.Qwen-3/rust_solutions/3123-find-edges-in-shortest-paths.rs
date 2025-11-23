impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn find_shortest_path_edges(n: i32, edges: Vec<Vec<i32>>, source: i32, sink: i32) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut graph = HashMap::new();
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            graph.entry(u).or_insert_with(Vec::new).push((v, w));
            graph.entry(v).or_insert_with(Vec::new).push((u, w));
        }

        let mut dist = vec![i32::MAX; n];
        dist[source as usize] = 0;
        let mut prev = vec![vec![]; n];

        let mut pq = VecDeque::new();
        pq.push_back((0, source as usize));

        while let Some((d, u)) = pq.pop_front() {
            if d > dist[u] {
                continue;
            }
            for &(v, w) in graph.get(&u).unwrap_or(&vec![]) {
                if dist[v] > d + w {
                    dist[v] = d + w;
                    prev[v].clear();
                    prev[v].push(u);
                    pq.push_back((dist[v], v));
                } else if dist[v] == d + w {
                    prev[v].push(u);
                }
            }
        }

        let mut result = Vec::new();
        let mut visited = vec![false; n];
        let mut stack = vec![sink as usize];
        while let Some(u) = stack.pop() {
            if visited[u] {
                continue;
            }
            visited[u] = true;
            for &p in &prev[u] {
                let u_idx = u;
                let p_idx = p;
                let edge = if u_idx < p_idx {
                    vec![p_idx as i32, u_idx as i32]
                } else {
                    vec![u_idx as i32, p_idx as i32]
                };
                result.push(edge);
                stack.push(p);
            }
        }

        result
    }
}
}