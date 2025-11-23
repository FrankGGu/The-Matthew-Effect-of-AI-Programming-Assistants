use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn restore_array(adjacent_pairs: Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for pair in &adjacent_pairs {
            graph.entry(pair[0]).or_insert(Vec::new()).push(pair[1]);
            graph.entry(pair[1]).or_insert(Vec::new()).push(pair[0]);
        }

        let mut start = 0;
        for (&node, &neighbors) in &graph {
            if neighbors.len() == 1 {
                start = node;
                break;
            }
        }

        let mut result = Vec::new();
        let mut visited = HashSet::new();
        let mut stack = vec![start];

        while let Some(curr) = stack.pop() {
            if visited.contains(&curr) {
                continue;
            }
            visited.insert(curr);
            result.push(curr);

            if let Some(neighbors) = graph.get(&curr) {
                for &neighbor in neighbors {
                    if !visited.contains(&neighbor) {
                        stack.push(neighbor);
                    }
                }
            }
        }

        result
    }
}