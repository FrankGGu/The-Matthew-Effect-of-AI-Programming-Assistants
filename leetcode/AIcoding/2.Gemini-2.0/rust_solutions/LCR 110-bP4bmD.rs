impl Solution {
    pub fn all_paths_source_target(graph: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut path: Vec<i32> = Vec::new();
        path.push(0);

        fn dfs(graph: &Vec<Vec<i32>>, node: i32, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            if node == graph.len() as i32 - 1 {
                result.push(path.clone());
                return;
            }

            for &neighbor in &graph[node as usize] {
                path.push(neighbor);
                dfs(graph, neighbor, path, result);
                path.pop();
            }
        }

        dfs(&graph, 0, &mut path, &mut result);
        result
    }
}