impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn is_bipartite(graph: Vec<Vec<i32>>) -> bool {
        let n = graph.len();
        let mut color = vec![-1; n];

        for i in 0..n {
            if color[i] == -1 {
                let mut queue = VecDeque::new();
                queue.push_back(i);
                color[i] = 0;

                while let Some(node) = queue.pop_front() {
                    for &neighbor in &graph[node] {
                        let neighbor = neighbor as usize;
                        if color[neighbor] == -1 {
                            color[neighbor] = 1 - color[node];
                            queue.push_back(neighbor);
                        } else if color[neighbor] == color[node] {
                            return false;
                        }
                    }
                }
            }
        }

        true
    }
}
}