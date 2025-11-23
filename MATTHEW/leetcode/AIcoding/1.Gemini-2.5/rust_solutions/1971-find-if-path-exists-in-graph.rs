struct Solution;

impl Solution {
    pub fn valid_path(n: i32, edges: Vec<Vec<i32>>, source: i32, destination: i32) -> bool {
        if source == destination {
            return true;
        }

        let mut adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v as i32);
            adj[v].push(u as i32);
        }

        let mut visited: Vec<bool> = vec![false; n as usize];
        let mut queue: std::collections::VecDeque<i32> = std::collections::VecDeque::new();

        queue.push_back(source);
        visited[source as usize] = true;

        while let Some(node) = queue.pop_front() {
            if node == destination {
                return true;
            }

            for &neighbor in &adj[node as usize] {
                if !visited[neighbor as usize] {
                    visited[neighbor as usize] = true;
                    queue.push_back(neighbor);
                }
            }
        }

        false
    }
}