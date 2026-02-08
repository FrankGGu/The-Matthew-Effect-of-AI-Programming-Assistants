impl Solution {
    pub fn highest_edge_score(edges: Vec<i32>) -> i32 {
        let mut scores = vec![0; edges.len()];
        for (i, &node) in edges.iter().enumerate() {
            scores[node as usize] += i as i32;
        }
        scores.iter().enumerate().max_by_key(|&(_, &score)| score).map(|(idx, _)| idx as i32).unwrap_or(-1)
    }
}