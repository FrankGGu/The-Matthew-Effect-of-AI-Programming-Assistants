use std::collections::{BinaryHeap, HashMap};

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct Edge {
    node: usize,
    weight: i32,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct State {
    cost: i32,
    position: usize,
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(other.cost.cmp(&self.cost))
    }
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.cost.cmp(&self.cost)
    }
}

struct Graph {
    adj: Vec<Vec<Edge>>,
}

impl Graph {
    fn new(n: usize) -> Self {
        Graph {
            adj: vec![Vec::new(); n],
        }
    }

    fn add_edge(&mut self, u: usize, v: usize, w: i32) {
        self.adj[u].push(Edge { node: v, weight: w });
        self.adj[v].push(Edge { node: u, weight: w });
    }

    fn dijkstra(&self, start: usize) -> Vec<i32> {
        let mut dist = vec![i32::MAX; self.adj.len()];
        let mut heap = BinaryHeap::new();

        dist[start] = 0;
        heap.push(State {
            cost: 0,
            position: start,
        });

        while let Some(State { cost, position }) = heap.pop() {
            if cost > dist[position] {
                continue;
            }

            for edge in &self.adj[position] {
                let next = State {
                    cost: cost + edge.weight,
                    position: edge.node,
                };

                if next.cost < dist[next.position] {
                    dist[next.position] = next.cost;
                    heap.push(next);
                }
            }
        }

        dist
    }
}

impl Solution {
    pub fn shortest_distance_after_road_addition(n: i32, roads: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = Graph::new(n);
        let mut original_edges = HashMap::new();

        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let w = road[2];
            graph.add_edge(u, v, w);
            let key = if u < v { (u, v) } else { (v, u) };
            original_edges.insert(key, w);
        }

        let mut dist0 = graph.dijkstra(0);
        let mut dist1 = graph.dijkstra(n - 1);

        let mut res = Vec::new();
        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            let w = query[2];
            let key = if u < v { (u, v) } else { (v, u) };
            if original_edges.contains_key(&key) {
                res.push(dist0[n - 1]);
                continue;
            }

            let candidate1 = dist0[u].saturating_add(w).saturating_add(dist1[v]);
            let candidate2 = dist0[v].saturating_add(w).saturating_add(dist1[u]);
            let min_candidate = candidate1.min(candidate2);
            res.push(min_candidate.min(dist0[n - 1]));
        }

        res
    }
}