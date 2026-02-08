use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Graph {
    n: i32,
    adj: Vec<Vec<(i32, i32)>>,
}

impl Graph {
    fn new(n: i32, edges: Vec<Vec<i32>>) -> Self {
        let mut adj: Vec<Vec<(i32, i32)>> = vec![vec![]; n as usize];
        for edge in edges {
            adj[edge[0] as usize].push((edge[1], edge[2]));
        }
        Graph { n, adj }
    }

    fn add_edge(&mut self, edge: Vec<i32>) {
        self.adj[edge[0] as usize].push((edge[1], edge[2]));
    }

    fn shortest_path(&self, node1: i32, node2: i32) -> i32 {
        let mut dist: Vec<i32> = vec![i32::MAX; self.n as usize];
        dist[node1 as usize] = 0;
        let mut pq: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();
        pq.push(Reverse((0, node1)));

        while let Some(Reverse((d, u))) = pq.pop() {
            if d > dist[u as usize] {
                continue;
            }

            for &(v, weight) in &self.adj[u as usize] {
                if dist[v as usize] > dist[u as usize] + weight {
                    dist[v as usize] = dist[u as usize] + weight;
                    pq.push(Reverse((dist[v as usize], v)));
                }
            }
        }

        if dist[node2 as usize] == i32::MAX {
            -1
        } else {
            dist[node2 as usize]
        }
    }
}