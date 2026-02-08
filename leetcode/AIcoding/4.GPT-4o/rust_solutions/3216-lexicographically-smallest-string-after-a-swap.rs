impl Solution {
    pub fn smallest_string_with_swaps(s: String, pairs: Vec<Vec<i32>>) -> String {
        use std::collections::HashMap;

        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for pair in pairs {
            graph.entry(pair[0]).or_insert(Vec::new()).push(pair[1]);
            graph.entry(pair[1]).or_insert(Vec::new()).push(pair[0]);
        }

        let mut visited = vec![false; s.len()];
        let mut result = s.chars().collect::<Vec<_>>();

        fn dfs(node: i32, graph: &HashMap<i32, Vec<i32>>, visited: &mut Vec<bool>, indices: &mut Vec<i32>, chars: &mut Vec<char>) {
            visited[node as usize] = true;
            indices.push(node);
            chars.push(result[node as usize]);
            for &neighbor in graph.get(&node).unwrap_or(&Vec::new()) {
                if !visited[neighbor as usize] {
                    dfs(neighbor, graph, visited, indices, chars);
                }
            }
        }

        for i in 0..s.len() {
            if !visited[i] {
                let mut indices = Vec::new();
                let mut chars = Vec::new();
                dfs(i as i32, &graph, &mut visited, &mut indices, &mut chars);
                indices.sort();
                chars.sort();
                for j in 0..indices.len() {
                    result[indices[j] as usize] = chars[j];
                }
            }
        }

        result.into_iter().collect()
    }
}