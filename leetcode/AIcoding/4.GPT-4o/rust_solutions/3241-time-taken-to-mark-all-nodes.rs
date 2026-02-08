use std::collections::HashMap;

impl Solution {
    pub fn time_to_mark_all_nodes(n: i32, edges: Vec<Vec<i32>>, time: i32) -> i32 {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut visited = vec![false; n as usize];
        let mut max_time = 0;

        fn dfs(node: usize, graph: &Vec<Vec<i32>>, visited: &mut Vec<bool>, time: i32) -> i32 {
            visited[node] = true;
            let mut max_child_time = 0;

            for &neighbor in &graph[node] {
                if !visited[neighbor as usize] {
                    max_child_time = max_child_time.max(dfs(neighbor as usize, graph, visited, time));
                }
            }
            max_child_time + time
        }

        for i in 0..n as usize {
            if !visited[i] {
                max_time = max_time.max(dfs(i, &graph, &mut visited, time));
            }
        }

        max_time
    }
}