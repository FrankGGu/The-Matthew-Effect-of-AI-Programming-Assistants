use std::collections::{HashMap, HashSet};

pub struct Solution;

impl Solution {
    pub fn get_ancestors(n: i32, edges: Vec<Vec<i32>>) -> Vec<HashSet<i32>> {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in edges {
            graph.entry(edge[1]).or_default().push(edge[0]);
        }

        let mut result = vec![HashSet::new(); n as usize];

        for node in 0..n {
            let mut visited = HashSet::new();
            Self::dfs(node, &graph, &mut visited);
            result[node as usize] = visited;
        }

        result
    }

    fn dfs(node: i32, graph: &HashMap<i32, Vec<i32>>, visited: &mut HashSet<i32>) {
        if visited.contains(&node) {
            return;
        }
        visited.insert(node);
        if let Some(neighbors) = graph.get(&node) {
            for &neighbor in neighbors {
                Self::dfs(neighbor, graph, visited);
            }
        }
    }
}