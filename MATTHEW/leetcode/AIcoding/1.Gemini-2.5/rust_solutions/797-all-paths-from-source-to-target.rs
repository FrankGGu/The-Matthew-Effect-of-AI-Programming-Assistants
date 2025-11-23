struct Solution;

impl Solution {
    pub fn all_paths_source_target(graph: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = graph.len();
        let target = (n - 1) as i32;
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_path: Vec<i32> = Vec::new();

        Self::dfs(&graph, 0, target, &mut current_path, &mut result);

        result
    }

    fn dfs(
        graph: &Vec<Vec<i32>>,
        node: i32,
        target: i32,
        current_path: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        current_path.push(node);

        if node == target {
            result.push(current_path.clone());
        } else {
            for &neighbor in graph[node as usize].iter() {
                Self::dfs(graph, neighbor, target, current_path, result);
            }
        }

        current_path.pop();
    }
}