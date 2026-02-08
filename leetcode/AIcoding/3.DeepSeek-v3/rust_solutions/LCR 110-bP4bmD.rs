impl Solution {
    pub fn all_paths_source_target(graph: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut path = Vec::new();
        path.push(0);
        Self::dfs(0, &graph, &mut path, &mut result);
        result
    }

    fn dfs(node: i32, graph: &Vec<Vec<i32>>, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if node == (graph.len() - 1) as i32 {
            result.push(path.clone());
            return;
        }

        for &next in &graph[node as usize] {
            path.push(next);
            Self::dfs(next, graph, path, result);
            path.pop();
        }
    }
}