impl Solution {

use std::collections::{BinaryHeap, HashMap};

impl Solution {
    pub fn min_edges_to_make_connected(n: i32, edges: Vec<Vec<i32>>, parent: Vec<Vec<i32>>) -> i32 {
        use std::cmp::Reverse;

        let n = n as usize;
        let mut graph = vec![vec![]; n];

        for e in &edges {
            let u = e[0] as usize;
            let v = e[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut components = 0;

        for i in 0..n {
            if !visited[i] {
                components += 1;
                dfs(i, &mut visited, &graph);
            }
        }

        if components == 1 {
            return 0;
        }

        let mut adj = HashMap::new();
        for e in &edges {
            let u = e[0] as usize;
            let v = e[1] as usize;
            adj.entry(u).or_insert_with(Vec::new).push((v, 1));
            adj.entry(v).or_insert_with(Vec::new).push((u, 1));
        }

        let mut dist = vec![i32::MAX; n];
        let mut pq = BinaryHeap::new();

        for p in &parent {
            let u = p[0] as usize;
            let v = p[1] as usize;
            dist[u] = 0;
            pq.push(Reverse((0, u)));
        }

        while let Some(Reverse((d, u))) = pq.pop() {
            if d > dist[u] {
                continue;
            }
            for &(v, w) in adj.get(&u).unwrap_or(&vec![]) {
                if dist[v] > d + w {
                    dist[v] = d + w;
                    pq.push(Reverse((dist[v], v)));
                }
            }
        }

        let mut total = 0;
        for i in 0..n {
            if dist[i] == i32::MAX {
                return -1;
            }
            total += dist[i];
        }

        total / (components - 1)
    }
}

fn dfs(v: usize, visited: &mut Vec<bool>, graph: &Vec<Vec<usize>>) {
    visited[v] = true;
    for &u in graph[v].iter() {
        if !visited[u] {
            dfs(u, visited, graph);
        }
    }
}
}