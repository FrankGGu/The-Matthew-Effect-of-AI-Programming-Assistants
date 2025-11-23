use std::collections::{HashSet, HashMap};

struct Graph {
    adjacency_list: HashMap<i32, Vec<i32>>,
}

impl Graph {
    fn new(edges: Vec<Vec<i32>>) -> Self {
        let mut adjacency_list = HashMap::new();
        for edge in edges {
            adjacency_list.entry(edge[0]).or_insert_with(Vec::new).push(edge[1]);
            adjacency_list.entry(edge[1]).or_insert_with(Vec::new).push(edge[0]);
        }
        Graph { adjacency_list }
    }

    fn dfs(&self, node: i32, target: i32, visited: &mut HashSet<i32>) -> bool {
        if node == target {
            return true;
        }
        visited.insert(node);
        if let Some(neighbors) = self.adjacency_list.get(&node) {
            for &neighbor in neighbors {
                if !visited.contains(&neighbor) && self.dfs(neighbor, target, visited) {
                    return true;
                }
            }
        }
        false
    }
}

struct Solution;

impl Solution {
    pub fn valid_path(n: i32, edges: Vec<Vec<i32>>, source: i32, destination: i32) -> bool {
        if source == destination {
            return true;
        }
        let graph = Graph::new(edges);
        let mut visited = HashSet::new();
        graph.dfs(source, destination, &mut visited)
    }
}