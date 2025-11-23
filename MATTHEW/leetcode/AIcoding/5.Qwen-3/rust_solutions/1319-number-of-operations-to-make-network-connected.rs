impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn make_connected(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        if connections.len() < (n - 1) as usize {
            return -1;
        }

        let n = n as usize;
        let mut graph = vec![Vec::new(); n];
        for conn in connections {
            let u = conn[0] as usize;
            let v = conn[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut components = 0;

        for i in 0..n {
            if !visited[i] {
                components += 1;
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

        components - 1
    }
}
}