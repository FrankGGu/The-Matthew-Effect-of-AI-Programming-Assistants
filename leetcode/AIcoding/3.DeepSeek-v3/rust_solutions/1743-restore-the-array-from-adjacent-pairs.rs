use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn restore_array(adjacent_pairs: Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for pair in adjacent_pairs {
            let u = pair[0];
            let v = pair[1];
            graph.entry(u).or_default().push(v);
            graph.entry(v).or_default().push(u);
        }

        let mut start = 0;
        for (&key, neighbors) in &graph {
            if neighbors.len() == 1 {
                start = key;
                break;
            }
        }

        let mut result = Vec::new();
        let mut visited = HashSet::new();
        let mut stack = vec![start];
        visited.insert(start);

        while let Some(node) = stack.pop() {
            result.push(node);
            if let Some(neighbors) = graph.get(&node) {
                for &neighbor in neighbors {
                    if !visited.contains(&neighbor) {
                        visited.insert(neighbor);
                        stack.push(neighbor);
                    }
                }
            }
        }

        result
    }
}