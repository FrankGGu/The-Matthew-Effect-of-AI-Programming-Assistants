impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn count_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph = vec![HashSet::new(); n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].insert(v);
            graph[v].insert(u);
        }

        let mut visited = vec![false; n];
        let mut result = 0;

        for i in 0..n {
            if !visited[i] {
                let mut queue = VecDeque::new();
                queue.push_back(i);
                visited[i] = true;
                let mut nodes = vec![];

                while let Some(node) = queue.pop_front() {
                    nodes.push(node);
                    for neighbor in &graph[node] {
                        if !visited[*neighbor] {
                            visited[*neighbor] = true;
                            queue.push_back(*neighbor);
                        }
                    }
                }

                let size = nodes.len();
                let mut is_complete = true;

                for &node in &nodes {
                    if graph[node].len() != size - 1 {
                        is_complete = false;
                        break;
                    }
                }

                if is_complete {
                    result += 1;
                }
            }
        }

        result as i32
    }
}
}