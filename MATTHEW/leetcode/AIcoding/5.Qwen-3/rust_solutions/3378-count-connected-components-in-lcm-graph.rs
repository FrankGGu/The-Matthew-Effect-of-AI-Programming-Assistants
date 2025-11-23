impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn count_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph = vec![Vec::new(); n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut count = 0;

        for i in 0..n {
            if !visited[i] {
                count += 1;
                let mut queue = VecDeque::new();
                queue.push_back(i);
                visited[i] = true;

                while let Some(node) = queue.pop_front() {
                    for &neighbor in &graph[node] {
                        if !visited[neighbor] {
                            visited[neighbor] = true;
                            queue.push_back(neighbor);
                        }
                    }
                }
            }
        }

        count as i32
    }
}
}