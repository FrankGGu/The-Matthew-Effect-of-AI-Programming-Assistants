use std::collections::HashSet;

impl Solution {
    pub fn minimum_time(nodes: Vec<i32>, edges: Vec<Vec<i32>>, time: Vec<i32>) -> i32 {
        let n = nodes.len();
        let mut graph = vec![vec![]; n];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut visited = HashSet::new();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(0);
        visited.insert(0);
        let mut total_time = 0;

        while let Some(node) = queue.pop_front() {
            total_time += time[node as usize];
            for &neighbor in &graph[node as usize] {
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                }
            }
        }

        total_time
    }
}