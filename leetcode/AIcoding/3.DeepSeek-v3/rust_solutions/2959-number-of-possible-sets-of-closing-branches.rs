use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn number_of_sets(n: i32, max_distance: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let max_distance = max_distance as i32;
        let mut graph = vec![vec![i32::MAX; n]; n];
        for i in 0..n {
            graph[i][i] = 0;
        }
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let w = road[2];
            graph[u][v] = graph[u][v].min(w);
            graph[v][u] = graph[v][u].min(w);
        }

        let mut res = 0;
        for mask in 0..(1 << n) {
            let mut nodes = Vec::new();
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    nodes.push(i);
                }
            }
            if Self::is_valid(&nodes, &graph, max_distance) {
                res += 1;
            }
        }
        res
    }

    fn is_valid(nodes: &[usize], graph: &Vec<Vec<i32>>, max_distance: i32) -> bool {
        let k = nodes.len();
        for i in 0..k {
            for j in 0..k {
                let u = nodes[i];
                let v = nodes[j];
                let dist = Self::dijkstra(u, v, nodes, graph);
                if dist > max_distance {
                    return false;
                }
            }
        }
        true
    }

    fn dijkstra(start: usize, end: usize, nodes: &[usize], graph: &Vec<Vec<i32>>) -> i32 {
        let k = nodes.len();
        let node_set: HashSet<_> = nodes.iter().cloned().collect();
        let mut dist = vec![i32::MAX; graph.len()];
        dist[start] = 0;
        let mut heap = VecDeque::new();
        heap.push_back(start);

        while let Some(u) = heap.pop_front() {
            for v in 0..graph.len() {
                if !node_set.contains(&v) {
                    continue;
                }
                if graph[u][v] != i32::MAX {
                    let new_dist = dist[u] + graph[u][v];
                    if new_dist < dist[v] {
                        dist[v] = new_dist;
                        heap.push_back(v);
                    }
                }
            }
        }
        dist[end]
    }
}