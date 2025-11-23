use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn min_reorder(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        let mut graph: HashMap<i32, Vec<(i32, bool)>> = HashMap::new();
        for conn in connections {
            graph.entry(conn[0]).or_insert(vec![]).push((conn[1], true));
            graph.entry(conn[1]).or_insert(vec![]).push((conn[0], false));
        }

        let mut visited = HashSet::new();
        let mut count = 0;

        fn dfs(node: i32, graph: &HashMap<i32, Vec<(i32, bool)>>, visited: &mut HashSet<i32>, count: &mut i32) {
            visited.insert(node);
            for &(neighbor, direction) in &graph[&node] {
                if !visited.contains(&neighbor) {
                    if direction {
                        *count += 1;
                    }
                    dfs(neighbor, graph, visited, count);
                }
            }
        }

        dfs(0, &graph, &mut visited, &mut count);
        count
    }
}