use std::collections::VecDeque;

impl Solution {
    pub fn frog_position(n: i32, edges: Vec<Vec<i32>>, t: i32, target: i32) -> f64 {
        let n = n as usize;
        let target = target as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n + 1];
        for edge in &edges {
            adj[edge[0] as usize].push(edge[1] as usize);
            adj[edge[1] as usize].push(edge[0] as usize);
        }

        let mut visited = vec![false; n + 1];
        let mut queue: VecDeque<(usize, i32, f64)> = VecDeque::new();
        queue.push_back((1, 0, 1.0));
        visited[1] = true;

        while let Some((node, time, prob)) = queue.pop_front() {
            if time > t {
                continue;
            }

            if node == target {
                if time == t || adj[node].iter().filter(|&&x| x != 1 && !visited[x]).count() == 0 {
                    return prob;
                } else {
                    return 0.0;
                }
            }

            let mut next_nodes = vec![];
            for &neighbor in &adj[node] {
                if !visited[neighbor] {
                    next_nodes.push(neighbor);
                }
            }

            let num_next = next_nodes.len();
            if num_next > 0 {
                let next_prob = prob / (num_next as f64);
                for &next_node in &next_nodes {
                    visited[next_node] = true;
                    queue.push_back((next_node, time + 1, next_prob));
                }
            } else {
                if time < t && node == target{
                    return prob;
                }
            }
        }

        0.0
    }
}