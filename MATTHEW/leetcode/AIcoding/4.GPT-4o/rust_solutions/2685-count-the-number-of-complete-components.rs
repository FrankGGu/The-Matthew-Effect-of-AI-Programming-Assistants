use std::collections::HashSet;

pub struct Solution;

impl Solution {
    pub fn count_complete_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut visited = vec![false; n as usize];
        let mut complete_count = 0;

        for i in 0..n {
            if !visited[i as usize] {
                let mut size = 0;
                let mut edges_count = 0;
                let mut stack = vec![i];

                while let Some(node) = stack.pop() {
                    if visited[node as usize] {
                        continue;
                    }
                    visited[node as usize] = true;
                    size += 1;
                    edges_count += graph[node as usize].len() as i32;
                    for &neighbor in &graph[node as usize] {
                        if !visited[neighbor as usize] {
                            stack.push(neighbor);
                        }
                    }
                }

                if edges_count == 2 * (size - 1) {
                    complete_count += 1;
                }
            }
        }

        complete_count
    }
}