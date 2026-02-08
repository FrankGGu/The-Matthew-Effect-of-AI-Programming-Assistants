use std::collections::{HashMap, HashSet};

struct Graph {
    edges: HashMap<i32, Vec<i32>>,
}

impl Graph {
    fn new() -> Self {
        Graph {
            edges: HashMap::new(),
        }
    }

    fn add_edge(&mut self, u: i32, v: i32) {
        self.edges.entry(u).or_insert(vec![]).push(v);
        self.edges.entry(v).or_insert(vec![]).push(u);
    }

    fn has_path_dfs(&self, start: i32, end: i32, visited: &mut HashSet<i32>) -> bool {
        if start == end {
            return true;
        }
        visited.insert(start);
        if let Some(neighbors) = self.edges.get(&start) {
            for &neighbor in neighbors {
                if !visited.contains(&neighbor) && self.has_path_dfs(neighbor, end, visited) {
                    return true;
                }
            }
        }
        false
    }
}

pub struct Solution;

impl Solution {
    pub fn path_existence(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let mut graph = Graph::new();
        for edge in edges {
            graph.add_edge(edge[0], edge[1]);
        }
        queries.iter()
            .map(|query| {
                let mut visited = HashSet::new();
                graph.has_path_dfs(query[0], query[1], &mut visited)
            })
            .collect()
    }
}