use std::collections::{HashSet, HashMap, VecDeque};

impl Solution {
    pub fn shortest_path_length(graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();
        let mut all_visited = (1 << n) - 1;
        let mut answer = std::i32::MAX;

        for i in 0..n {
            queue.push_back((i, 1 << i, 0));
            visited.insert((i, 1 << i));
        }

        while !queue.is_empty() {
            let (node, mask, dist) = queue.pop_front().unwrap();

            if mask == all_visited {
                answer = answer.min(dist);
                continue;
            }

            for &next in &graph[node] {
                let next_mask = mask | (1 << next);
                if !visited.contains(&(next as usize, next_mask)) {
                    visited.insert((next as usize, next_mask));
                    queue.push_back((next as usize, next_mask, dist + 1));
                }
            }
        }

        answer
    }
}