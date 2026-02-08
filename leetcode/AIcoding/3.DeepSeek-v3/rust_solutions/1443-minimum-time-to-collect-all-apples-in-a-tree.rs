use std::collections::HashMap;

impl Solution {
    pub fn min_time(n: i32, edges: Vec<Vec<i32>>, has_apple: Vec<bool>) -> i32 {
        let n = n as usize;
        let mut adj = HashMap::new();
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj.entry(u).or_insert(Vec::new()).push(v);
            adj.entry(v).or_insert(Vec::new()).push(u);
        }

        fn dfs(node: usize, parent: usize, adj: &HashMap<usize, Vec<usize>>, has_apple: &[bool]) -> i32 {
            let mut total_time = 0;
            if let Some(children) = adj.get(&node) {
                for &child in children {
                    if child != parent {
                        let child_time = dfs(child, node, adj, has_apple);
                        if child_time > 0 || has_apple[child] {
                            total_time += child_time + 2;
                        }
                    }
                }
            }
            total_time
        }

        dfs(0, 0, &adj, &has_apple)
    }
}