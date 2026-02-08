impl Solution {
    pub fn find_destination_path(n: i32, edges: Vec<Vec<i32>>, start: i32, end: i32) -> Vec<i32> {
        use std::collections::{HashMap, HashSet};

        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in edges {
            graph.entry(edge[0]).or_insert(Vec::new()).push(edge[1]);
            graph.entry(edge[1]).or_insert(Vec::new()).push(edge[0]);
        }

        let mut visited = HashSet::new();
        let mut path = Vec::new();
        let mut result = Vec::new();

        fn dfs(
            node: i32,
            end: i32,
            graph: &HashMap<i32, Vec<i32>>,
            visited: &mut HashSet<i32>,
            path: &mut Vec<i32>,
            result: &mut Vec<i32>,
        ) {
            visited.insert(node);
            path.push(node);

            if node == end {
                result.extend_from_slice(&path);
            } else {
                if let Some(neighbors) = graph.get(&node) {
                    for &neighbor in neighbors {
                        if !visited.contains(&neighbor) {
                            dfs(neighbor, end, graph, visited, path, result);
                        }
                    }
                }
            }

            path.pop();
            visited.remove(&node);
        }

        dfs(start, end, &graph, &mut visited, &mut path, &mut result);
        result
    }
}