impl Solution {
    pub fn all_paths_source_target(graph: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = graph.len();
        let mut paths: Vec<Vec<i32>> = Vec::new();
        let mut path: Vec<i32> = Vec::new();

        fn dfs(graph: &Vec<Vec<i32>>, node: usize, path: &mut Vec<i32>, paths: &mut Vec<Vec<i32>>) {
            path.push(node as i32);

            if node == graph.len() - 1 {
                paths.push(path.clone());
            } else {
                for &neighbor in &graph[node] {
                    dfs(graph, neighbor as usize, path, paths);
                }
            }

            path.pop();
        }

        dfs(&graph, 0, &mut path, &mut paths);
        paths
    }
}