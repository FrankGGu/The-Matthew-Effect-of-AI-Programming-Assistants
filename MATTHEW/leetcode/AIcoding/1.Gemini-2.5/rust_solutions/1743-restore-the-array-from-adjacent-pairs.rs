use std::collections::HashMap;

impl Solution {
    pub fn restore_array(adjacent_pairs: Vec<Vec<i32>>) -> Vec<i32> {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();

        for pair in &adjacent_pairs {
            adj.entry(pair[0]).or_insert_with(Vec::new).push(pair[1]);
            adj.entry(pair[1]).or_insert_with(Vec::new).push(pair[0]);
        }

        let mut start_node = 0;
        for (&node, neighbors) in &adj {
            if neighbors.len() == 1 {
                start_node = node;
                break;
            }
        }

        let n = adjacent_pairs.len() + 1;
        let mut result = Vec::with_capacity(n);

        let mut prev = start_node;
        let mut curr = start_node;
        result.push(curr);

        for _ in 1..n {
            let neighbors = adj.get(&curr).unwrap();
            let next_node = if neighbors[0] == prev {
                neighbors[1]
            } else {
                neighbors[0]
            };
            result.push(next_node);
            prev = curr;
            curr = next_node;
        }

        result
    }
}