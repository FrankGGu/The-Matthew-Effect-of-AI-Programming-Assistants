impl Solution {
    pub fn all_paths_source_target(graph: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let target = (graph.len() - 1) as i32;
        let mut result = Vec::new();
        let mut path = Vec::new();

        fn dfs(graph: &Vec<Vec<i32>>, node: i32, target: i32, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            path.push(node);
            if node == target {
                result.push(path.clone());
            } else {
                for &next in &graph[node as usize] {
                    dfs(graph, next, target, path, result);
                }
            }
            path.pop();
        }

        dfs(&graph, 0, target, &mut path, &mut result);
        result
    }
}