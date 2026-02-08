use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Debug, Clone)]
struct Edge {
    to: usize,
    cost: i32,
}

#[derive(Debug)]
struct Graph {
    adj: Vec<Vec<Edge>>,
}

impl Graph {
    fn new(n: i32, edges: Vec<Vec<i32>>) -> Self {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let from = edge[0] as usize;
            let to = edge[1] as usize;
            let cost = edge[2];
            adj[from].push(Edge { to, cost });
        }
        Graph { adj }
    }

    fn add_edge(&mut self, edge: Vec<i32>) {
        let from = edge[0] as usize;
        let to = edge[1] as usize;
        let cost = edge[2];
        self.adj[from].push(Edge { to, cost });
    }

    fn shortest_path(&self, node1: i32, node2: i32) -> i32 {
        let start = node1 as usize;
        let end = node2 as usize;
        let mut dist = vec![i32::MAX; self.adj.len()];
        dist[start] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(State { cost: 0, node: start });

        while let Some(State { cost, node }) = heap.pop() {
            if node == end {
                return cost;
            }
            if cost > dist[node] {
                continue;
            }
            for edge in &self.adj[node] {
                let next = State {
                    cost: cost + edge.cost,
                    node: edge.to,
                };
                if next.cost < dist[next.node] {
                    dist[next.node] = next.cost;
                    heap.push(next);
                }
            }
        }
        -1
    }
}

#[derive(Copy, Clone, Eq, PartialEq)]
struct State {
    cost: i32,
    node: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}