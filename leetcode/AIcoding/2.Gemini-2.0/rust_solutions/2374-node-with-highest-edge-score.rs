use std::collections::HashMap;

impl Solution {
    pub fn edge_score(edges: Vec<i32>) -> i32 {
        let mut scores: HashMap<i32, i64> = HashMap::new();
        for (i, &edge) in edges.iter().enumerate() {
            let entry = scores.entry(edge).or_insert(0);
            *entry += i as i64;
        }

        let mut max_score = i64::min_value();
        let mut max_node = -1;

        for (&node, &score) in scores.iter() {
            if score > max_score {
                max_score = score;
                max_node = node;
            } else if score == max_score && node < max_node {
                max_node = node;
            }
        }

        max_node
    }
}