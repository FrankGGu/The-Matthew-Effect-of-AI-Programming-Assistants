use std::collections::HashMap;

pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>) -> i64 {
    let mut graph = vec![vec![]; n as usize];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut sizes = vec![0; n as usize];
    let mut visited = vec![false; n as usize];

    fn dfs(node: usize, graph: &Vec<Vec<i32>>, visited: &mut Vec<bool>, sizes: &mut Vec<i32>) -> i32 {
        visited[node] = true;
        let mut size = 1;
        for &neighbor in &graph[node] {
            if !visited[neighbor as usize] {
                size += dfs(neighbor as usize, graph, visited, sizes);
            }
        }
        sizes[node] = size;
        size
    }

    let total = dfs(0, &graph, &mut visited, &mut sizes);
    let mut result = 0;
    let mut count = 0;

    for size in sizes {
        if size > 0 {
            result += count * size;
            count += size;
        }
    }

    result as i64
}