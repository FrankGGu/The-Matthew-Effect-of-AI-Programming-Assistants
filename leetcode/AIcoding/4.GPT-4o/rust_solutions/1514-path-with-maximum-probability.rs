use std::collections::BinaryHeap;

pub fn max_probability(n: i32, edges: Vec<Vec<i32>>, succ_prob: Vec<f64>, start: i32, end: i32) -> f64 {
    let mut graph = vec![vec![]; n as usize];
    for (i, edge) in edges.iter().enumerate() {
        let (u, v) = (edge[0] as usize, edge[1] as usize);
        graph[u].push((v, succ_prob[i]));
        graph[v].push((u, succ_prob[i]));
    }

    let mut max_probs = vec![0.0; n as usize];
    max_probs[start as usize] = 1.0;

    let mut heap = BinaryHeap::new();
    heap.push((1.0, start));

    while let Some((prob, node)) = heap.pop() {
        let prob = -prob;
        if node == end {
            return prob;
        }
        if prob < max_probs[node as usize] {
            continue;
        }
        for &(neighbor, edge_prob) in &graph[node as usize] {
            let new_prob = prob * edge_prob;
            if new_prob > max_probs[neighbor as usize] {
                max_probs[neighbor as usize] = new_prob;
                heap.push((-new_prob, neighbor));
            }
        }
    }

    0.0
}