use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn count_valid_paths(n: i32, edges: Vec<Vec<i32>>, start: i32, end: i32) -> i32 {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut visited = HashSet::new();
        let mut count = 0;

        fn dfs(node: i32, end: i32, visited: &mut HashSet<i32>, graph: &Vec<Vec<i32>>, count: &mut i32) {
            if node == end {
                *count += 1;
                return;
            }
            visited.insert(node);
            for &neighbor in &graph[node as usize] {
                if !visited.contains(&neighbor) {
                    dfs(neighbor, end, visited, graph, count);
                }
            }
            visited.remove(&node);
        }

        dfs(start, end, &mut visited, &graph, &mut count);
        count
    }
}