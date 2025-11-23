use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn check_reconstruction(original: Vec<i32>, altered: Vec<Vec<i32>>) -> i32 {
        let mut graph = HashMap::new();
        let mut degrees = HashMap::new();

        for edge in altered {
            let (u, v) = (edge[0], edge[1]);
            graph.entry(u).or_insert_with(HashSet::new).insert(v);
            graph.entry(v).or_insert_with(HashSet::new).insert(u);
            *degrees.entry(u).or_insert(0) += 1;
            *degrees.entry(v).or_insert(0) += 1;
        }

        let mut queue = vec![];
        for &node in &original {
            if degrees.get(&node).is_none() {
                return 0;
            }
            if degrees[&node] == 1 {
                queue.push(node);
            }
        }

        let mut index = 0;
        while !queue.is_empty() {
            if index >= original.len() || queue.len() > 1 {
                return 0;
            }
            let current = queue.remove(0);
            if current != original[index] {
                return 0;
            }
            index += 1;
            if let Some(neighbors) = graph.remove(&current) {
                for &neighbor in &neighbors {
                    let degree = degrees.entry(neighbor).or_insert(0);
                    *degree -= 1;
                    if *degree == 1 {
                        queue.push(neighbor);
                    }
                }
            }
        }

        if index == original.len() {
            1
        } else {
            0
        }
    }
}