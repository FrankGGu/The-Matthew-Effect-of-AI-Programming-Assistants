use std::collections::VecDeque;

impl Solution {
    pub fn frog_position(n: i32, edges: Vec<Vec<i32>>, t: i32, target: i32) -> f64 {
        let mut graph = vec![vec![]; n as usize + 1];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut visited = vec![false; n as usize + 1];
        let mut queue = VecDeque::new();
        queue.push_back((1, 0.0, 0)); // node, probability, time
        visited[1] = true;

        while let Some((node, prob, time)) = queue.pop_front() {
            if time == t {
                return if node == target { prob } else { 0.0 };
            }

            let mut children_count = 0;
            for &neighbor in &graph[node as usize] {
                if !visited[neighbor as usize] {
                    children_count += 1;
                }
            }

            for &neighbor in &graph[node as usize] {
                if !visited[neighbor as usize] {
                    visited[neighbor as usize] = true;
                    queue.push_back((neighbor, prob / children_count as f64, time + 1));
                }
            }

            if children_count == 0 && node != target {
                return 0.0;
            }
        }

        0.0
    }
}