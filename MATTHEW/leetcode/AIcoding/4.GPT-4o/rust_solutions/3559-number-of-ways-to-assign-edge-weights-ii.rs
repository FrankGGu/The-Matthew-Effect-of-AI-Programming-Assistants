use std::collections::HashMap;

pub struct Solution;

impl Solution {
    pub fn number_of_ways(n: i32, edges: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut result = vec![];
        for &query in &queries {
            let mut count = 0;
            let mut visited = vec![false; n as usize];
            let mut stack = vec![0];
            visited[0] = true;

            while let Some(node) = stack.pop() {
                if node == n - 1 {
                    count += 1;
                }
                for &neighbor in &graph[node as usize] {
                    if !visited[neighbor as usize] {
                        visited[neighbor as usize] = true;
                        stack.push(neighbor);
                    }
                }
                visited[node as usize] = false;
            }
            result.push(count);
        }
        result
    }
}