impl Solution {
    pub fn all_paths_source_target(graph: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = graph.len() as i32;
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_path: Vec<i32> = Vec::new();

        Self::dfs(0, n - 1, &graph, &mut current_path, &mut result);

        result
    }

    fn dfs(
        node: i32,
        target: i32,
        graph: &Vec<Vec<i32>>,
        current_path: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        current_path.push(node);

        if node == target {
            result.push(current_path.clone());
        } else {
            for &neighbor in graph[node as usize].iter() {
                Self::dfs(neighbor, target, graph, current_path, result);
            }
        }

        current_path.pop();
    }
}