use std::collections::VecDeque;

impl Solution {
    pub fn shortest_path_length(graph: Vec<Vec<i32>>) -> i32 {
        let n = graph.len();
        if n == 1 {
            return 0;
        }

        let target_mask = (1 << n) - 1;
        let mut queue = VecDeque::new();
        let mut visited = vec![vec![false; 1 << n]; n];

        for i in 0..n {
            queue.push_back((i, 1 << i, 0));
            visited[i][1 << i] = true;
        }

        while let Some((node, mask, dist)) = queue.pop_front() {
            if mask == target_mask {
                return dist;
            }

            for &neighbor in &graph[node as usize] {
                let next_mask = mask | (1 << (neighbor as usize));
                if !visited[neighbor as usize][next_mask] {
                    visited[neighbor as usize][next_mask] = true;
                    queue.push_back((neighbor as usize, next_mask, dist + 1));
                }
            }
        }

        0
    }
}