use std::collections::{BinaryHeap, HashMap, HashSet};

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct State {
    cost: i32,
    node: i32,
}

impl Solution {
    pub fn find_answer(n: i32, edges: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for (i, edge) in edges.iter().enumerate() {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            graph[u].push((v, w, i));
            graph[v].push((u, w, i));
        }

        let (dist_from_start, dist_from_end) = Self::dijkstra(&graph, 0, n - 1);
        let shortest_path_length = dist_from_start[n - 1];
        if shortest_path_length == i32::MAX {
            return vec![false; edges.len()];
        }

        let mut is_in_shortest_path = vec![false; edges.len()];
        let mut visited = HashSet::new();
        Self::dfs(&graph, 0, n - 1, &dist_from_start, &dist_from_end, shortest_path_length, &mut is_in_shortest_path, &mut visited);

        is_in_shortest_path
    }

    fn dijkstra(graph: &Vec<Vec<(usize, i32, usize)>>, start: usize, end: usize) -> (Vec<i32>, Vec<i32>) {
        let n = graph.len();
        let mut dist_from_start = vec![i32::MAX; n];
        dist_from_start[start] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(State { cost: 0, node: start as i32 });

        while let Some(State { cost, node }) = heap.pop() {
            let node = node as usize;
            if cost > dist_from_start[node] {
                continue;
            }
            for &(neighbor, weight, _) in &graph[node] {
                let new_cost = cost + weight;
                if new_cost < dist_from_start[neighbor] {
                    dist_from_start[neighbor] = new_cost;
                    heap.push(State { cost: new_cost, node: neighbor as i32 });
                }
            }
        }

        let mut dist_from_end = vec![i32::MAX; n];
        dist_from_end[end] = 0;
        heap.push(State { cost: 0, node: end as i32 });

        while let Some(State { cost, node }) = heap.pop() {
            let node = node as usize;
            if cost > dist_from_end[node] {
                continue;
            }
            for &(neighbor, weight, _) in &graph[node] {
                let new_cost = cost + weight;
                if new_cost < dist_from_end[neighbor] {
                    dist_from_end[neighbor] = new_cost;
                    heap.push(State { cost: new_cost, node: neighbor as i32 });
                }
            }
        }

        (dist_from_start, dist_from_end)
    }

    fn dfs(
        graph: &Vec<Vec<(usize, i32, usize)>>,
        current: usize,
        end: usize,
        dist_from_start: &Vec<i32>,
        dist_from_end: &Vec<i32>,
        shortest_path_length: i32,
        is_in_shortest_path: &mut Vec<bool>,
        visited: &mut HashSet<(usize, usize)>,
    ) {
        if current == end {
            return;
        }
        for &(neighbor, weight, edge_idx) in &graph[current] {
            if dist_from_start[current] + weight + dist_from_end[neighbor] == shortest_path_length {
                if !visited.contains(&(current, neighbor)) {
                    is_in_shortest_path[edge_idx] = true;
                    visited.insert((current, neighbor));
                    visited.insert((neighbor, current));
                    Self::dfs(
                        graph,
                        neighbor,
                        end,
                        dist_from_start,
                        dist_from_end,
                        shortest_path_length,
                        is_in_shortest_path,
                        visited,
                    );
                }
            }
        }
    }
}