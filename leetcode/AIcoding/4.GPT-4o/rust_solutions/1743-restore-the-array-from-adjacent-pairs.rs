pub fn restore_array(adjacent_pairs: Vec<Vec<i32>>) -> Vec<i32> {
    use std::collections::HashMap;
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();

    for pair in adjacent_pairs {
        graph.entry(pair[0]).or_default().push(pair[1]);
        graph.entry(pair[1]).or_default().push(pair[0]);
    }

    let mut result = Vec::new();
    let mut visited = std::collections::HashSet::new();

    fn dfs(node: i32, graph: &HashMap<i32, Vec<i32>>, visited: &mut std::collections::HashSet<i32>, result: &mut Vec<i32>) {
        visited.insert(node);
        result.push(node);

        for &neighbor in &graph[&node] {
            if !visited.contains(&neighbor) {
                dfs(neighbor, graph, visited, result);
            }
        }
    }

    if let Some(&start) = graph.keys().next() {
        dfs(start, &graph, &mut visited, &mut result);
    }

    result
}