use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct State {
    cost: i32,
    position: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
            .then_with(|| self.position.cmp(&other.position))
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

const INF: i32 = 1_000_000_001;

struct Graph {
    adj_matrix: Vec<Vec<i32>>,
    n: usize,
}

impl Graph {
    fn new(n: i32, edges: Vec<Vec<i32>>) -> Self {
        let num_nodes = n as usize;
        let mut adj_matrix = vec![vec![INF; num_nodes]; num_nodes];

        for i in 0..num_nodes {
            adj_matrix[i][i] = 0;
        }

        let mut graph = Graph {
            adj_matrix,
            n: num_nodes,
        };

        for edge in edges {
            graph.add_edge(edge);
        }

        graph
    }

    fn add_edge(&mut self, edge: Vec<i32>) {
        let from = edge[0] as usize;
        let to = edge[1] as usize;
        let cost = edge[2];

        self.adj_matrix[from][to] = self.adj_matrix[from][to].min(cost);
    }

    fn shortest_path(&self, node1: i32, node2: i32) -> i32 {
        let start_node = node1 as usize;
        let end_node = node2 as usize;

        let mut dist: Vec<i32> = vec![INF; self.n];
        dist[start_node] = 0;

        let mut pq = BinaryHeap::new();
        pq.push(State { cost: 0, position: start_node });

        while let Some(State { cost, position }) = pq.pop() {
            if cost > dist[position] {
                continue;
            }

            if position == end_node {
                return cost;
            }

            for next_node in 0..self.n {
                let edge_cost = self.adj_matrix[position][next_node];

                if edge_cost != INF {
                    let new_cost = cost + edge_cost;
                    if new_cost < dist[next_node] {
                        dist[next_node] = new_cost;
                        pq.push(State { cost: new_cost, position: next_node });
                    }
                }
            }
        }

        if dist[end_node] == INF {
            -1
        } else {
            dist[end_node]
        }
    }
}