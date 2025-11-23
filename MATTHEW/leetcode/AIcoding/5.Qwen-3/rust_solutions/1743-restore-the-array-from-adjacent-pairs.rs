impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn restore_array(adjacent_pairs: Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph = HashMap::new();
        for pair in adjacent_pairs {
            let a = pair[0];
            let b = pair[1];
            graph.entry(a).or_insert(Vec::new()).push(b);
            graph.entry(b).or_insert(Vec::new()).push(a);
        }

        let start = graph.iter().find(|(_, v)| v.len() == 1).unwrap().0;

        let mut result = Vec::new();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        queue.push_back(*start);
        visited.insert(*start);

        while let Some(node) = queue.pop_front() {
            result.push(node);
            for &neighbor in graph.get(&node).unwrap() {
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                }
            }
        }

        result
    }
}

use std::collections::{HashSet, VecDeque};
}