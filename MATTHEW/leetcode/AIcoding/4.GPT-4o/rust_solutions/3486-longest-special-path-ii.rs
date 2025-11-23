impl Solution {
    pub fn longest_special_path(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashMap;
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        fn dfs(node: i32, parent: i32, graph: &Vec<Vec<i32>>, visited: &mut Vec<bool>, length: i32) -> i32 {
            visited[node as usize] = true;
            let mut max_length = length;
            for &neighbor in &graph[node as usize] {
                if neighbor != parent && !visited[neighbor as usize] {
                    max_length = max_length.max(dfs(neighbor, node, graph, visited, length + 1));
                }
            }
            visited[node as usize] = false;
            max_length
        }

        let mut max_path = 0;
        for i in 0..n {
            let mut visited = vec![false; n as usize];
            max_path = max_path.max(dfs(i, -1, &graph, &mut visited, 1));
        }
        max_path
    }
}