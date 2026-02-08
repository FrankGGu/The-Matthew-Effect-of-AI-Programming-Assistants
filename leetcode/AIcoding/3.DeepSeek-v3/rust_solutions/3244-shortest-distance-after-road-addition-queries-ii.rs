use std::collections::{HashMap, HashSet, BinaryHeap};
use std::cmp::Reverse;

struct Graph {
    adj: Vec<HashMap<usize, i32>>,
}

impl Graph {
    fn new(n: usize) -> Self {
        Graph {
            adj: vec![HashMap::new(); n],
        }
    }

    fn add_edge(&mut self, u: usize, v: usize, w: i32) {
        self.adj[u].insert(v, w);
        self.adj[v].insert(u, w);
    }

    fn dijkstra(&self, start: usize) -> Vec<i32> {
        let n = self.adj.len();
        let mut dist = vec![i32::MAX; n];
        let mut heap = BinaryHeap::new();
        dist[start] = 0;
        heap.push(Reverse((0, start)));

        while let Some(Reverse((d, u))) = heap.pop() {
            if d > dist[u] {
                continue;
            }
            for (&v, &w) in &self.adj[u] {
                if dist[v] > dist[u] + w {
                    dist[v] = dist[u] + w;
                    heap.push(Reverse((dist[v], v)));
                }
            }
        }
        dist
    }
}

struct DistanceGraph {
    dist: Vec<Vec<i32>>,
}

impl DistanceGraph {
    fn new(n: usize) -> Self {
        DistanceGraph {
            dist: vec![vec![i32::MAX; n]; n],
        }
    }

    fn update(&mut self, u: usize, v: usize, w: i32) {
        if self.dist[u][v] <= w {
            return;
        }
        self.dist[u][v] = w;
        self.dist[v][u] = w;
        let n = self.dist.len();
        for &k in &[u, v] {
            for i in 0..n {
                for j in 0..n {
                    if self.dist[i][k] != i32::MAX && self.dist[k][j] != i32::MAX {
                        if self.dist[i][j] > self.dist[i][k] + self.dist[k][j] {
                            self.dist[i][j] = self.dist[i][k] + self.dist[k][j];
                        }
                    }
                }
            }
        }
    }
}

struct Solution {
    graph: Graph,
    distance_graph: DistanceGraph,
}

impl Solution {
    fn new(n: i32, edges: Vec<Vec<i32>>) -> Self {
        let n = n as usize;
        let mut graph = Graph::new(n);
        let mut distance_graph = DistanceGraph::new(n);
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            graph.add_edge(u, v, w);
            distance_graph.update(u, v, w);
        }
        Solution { graph, distance_graph }
    }

    fn add_edge(&mut self, edge: Vec<i32>) {
        let u = edge[0] as usize;
        let v = edge[1] as usize;
        let w = edge[2];
        self.graph.add_edge(u, v, w);
        self.distance_graph.update(u, v, w);
    }

    fn shortest_path(&self, node1: i32, node2: i32) -> i32 {
        let u = node1 as usize;
        let v = node2 as usize;
        if self.distance_graph.dist[u][v] == i32::MAX {
            -1
        } else {
            self.distance_graph.dist[u][v]
        }
    }
}