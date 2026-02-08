use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn shortest_path_length(graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        for i in 0..n {
            let mask = 1 << i;
            queue.push_back((i, mask));
            visited.insert((i, mask));
        }

        let target = (1 << n) - 1;
        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (node, mask) = queue.pop_front().unwrap();
                if mask == target {
                    return steps;
                }
                for &neighbor in &graph[node] {
                    let new_mask = mask | (1 << neighbor);
                    if !visited.contains(&(neighbor as usize, new_mask)) {
                        visited.insert((neighbor as usize, new_mask));
                        queue.push_back((neighbor as usize, new_mask));
                    }
                }
            }
            steps += 1;
        }
        -1
    }
}