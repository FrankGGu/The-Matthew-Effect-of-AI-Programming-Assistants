use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(PartialEq, PartialOrd, Clone, Copy, Debug)]
struct State {
    node: i32,
    prob: f64,
}

impl Eq for State {}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        self.prob.partial_cmp(&other.prob).unwrap().then_with(|| self.node.cmp(&other.node)).reverse()
    }
}

impl Solution {
    pub fn max_probability(n: i32, edges: Vec<Vec<i32>>, succ_prob: Vec<f64>, start: i32, end: i32) -> f64 {
        let mut adj: Vec<Vec<(i32, f64)>> = vec![Vec::new(); n as usize];
        for i in 0..edges.len() {
            let u = edges[i][0] as usize;
            let v = edges[i][1] as usize;
            let p = succ_prob[i];
            adj[u].push((v as i32, p));
            adj[v].push((u as i32, p));
        }

        let mut dist: Vec<f64> = vec![0.0; n as usize];
        dist[start as usize] = 1.0;

        let mut pq: BinaryHeap<State> = BinaryHeap::new();
        pq.push(State { node: start, prob: 1.0 });

        while let Some(State { node, prob }) = pq.pop() {
            if prob < dist[node as usize] {
                continue;
            }

            for &(neighbor, edge_prob) in &adj[node as usize] {
                if dist[neighbor as usize] < prob * edge_prob {
                    dist[neighbor as usize] = prob * edge_prob;
                    pq.push(State { node: neighbor, prob: dist[neighbor as usize] });
                }
            }
        }

        dist[end as usize]
    }
}