pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>) -> i64 {
    let mut graph = vec![Vec::new(); n as usize];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut visited = vec![false; n as usize];
    let mut sizes = Vec::new();

    fn dfs(node: usize, graph: &Vec<Vec<i32>>, visited: &mut Vec<bool>) -> i32 {
        visited[node] = true;
        let mut size = 1;
        for &neighbor in &graph[node] {
            if !visited[neighbor as usize] {
                size += dfs(neighbor as usize, graph, visited);
            }
        }
        size
    }

    for i in 0..n as usize {
        if !visited[i] {
            sizes.push(dfs(i, &graph, &mut visited));
        }
    }

    let total_pairs = (n as i64 * (n as i64 - 1)) / 2;
    let mut sum_of_squares = 0;
    for size in sizes {
        sum_of_squares += (size as i64 * (size as i64 - 1)) / 2;
    }

    total_pairs - sum_of_squares
}