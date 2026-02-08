use std::collections::HashMap;

pub fn longest_special_path(n: i32, edges: Vec<Vec<i32>>) -> i32 {
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    for edge in edges {
        graph.entry(edge[0]).or_insert(vec![]).push(edge[1]);
        graph.entry(edge[1]).or_insert(vec![]).push(edge[0]);
    }

    let mut visited = vec![false; n as usize];
    let mut max_length = 0;

    fn dfs(node: i32, path_length: i32, graph: &HashMap<i32, Vec<i32>>, visited: &mut Vec<bool>, max_length: &mut i32) {
        visited[node as usize] = true;
        *max_length = (*max_length).max(path_length);

        for &neighbor in &graph[&node] {
            if !visited[neighbor as usize] {
                dfs(neighbor, path_length + 1, graph, visited, max_length);
            }
        }

        visited[node as usize] = false;
    }

    for i in 0..n {
        dfs(i, 0, &graph, &mut visited, &mut max_length);
    }

    max_length
}