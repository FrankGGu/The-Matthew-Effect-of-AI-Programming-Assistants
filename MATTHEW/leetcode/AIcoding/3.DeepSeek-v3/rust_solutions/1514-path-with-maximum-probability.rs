use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(PartialEq)]
struct State {
    prob: f64,
    node: usize,
}

impl Eq for State {}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.prob.partial_cmp(&other.prob)
    }
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        self.partial_cmp(other).unwrap_or(Ordering::Equal)
    }
}

impl Solution {
    pub fn max_probability(n: i32, edges: Vec<Vec<i32>>, succ_prob: Vec<f64>, start: i32, end: i32) -> f64 {
        let n = n as usize;
        let start = start as usize;
        let end = end as usize;
        let mut graph = vec![vec![]; n];
        for (i, edge) in edges.iter().enumerate() {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let prob = succ_prob[i];
            graph[u].push((v, prob));
            graph[v].push((u, prob));
        }

        let mut max_prob = vec![0.0; n];
        max_prob[start] = 1.0;
        let mut heap = BinaryHeap::new();
        heap.push(State { prob: 1.0, node: start });

        while let Some(State { prob, node }) = heap.pop() {
            if node == end {
                return prob;
            }
            if prob < max_prob[node] {
                continue;
            }
            for &(neighbor, edge_prob) in &graph[node] {
                let next_prob = prob * edge_prob;
                if next_prob > max_prob[neighbor] {
                    max_prob[neighbor] = next_prob;
                    heap.push(State { prob: next_prob, node: neighbor });
                }
            }
        }

        max_prob[end]
    }
}