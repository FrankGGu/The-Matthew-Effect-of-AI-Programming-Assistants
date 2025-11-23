use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn min_time(n: i32, edges: Vec<Vec<i32>>, has_apple: Vec<bool>) -> i32 {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in edges {
            adj.entry(edge[0]).or_insert(Vec::new()).push(edge[1]);
            adj.entry(edge[1]).or_insert(Vec::new()).push(edge[0]);
        }

        fn dfs(node: i32, parent: i32, adj: &HashMap<i32, Vec<i32>>, has_apple: &Vec<bool>) -> i32 {
            let mut time = 0;
            if let Some(neighbors) = adj.get(&node) {
                for &neighbor in neighbors {
                    if neighbor != parent {
                        let child_time = dfs(neighbor, node, adj, has_apple);
                        if child_time > 0 || has_apple[neighbor as usize] {
                            time += 2 + child_time;
                        }
                    }
                }
            }
            time
        }

        dfs(0, -1, &adj, &has_apple)
    }
}