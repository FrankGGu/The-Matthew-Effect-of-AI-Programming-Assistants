use std::collections::HashSet;

impl Solution {
    pub fn min_trio_degree(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![HashSet::new(); n + 1];
        let mut degree = vec![0; n + 1];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].insert(v);
            adj[v].insert(u);
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut min_degree = i32::MAX;

        for u in 1..=n {
            for &v in adj[u].iter() {
                if v <= u {
                    continue;
                }
                for &w in adj[v].iter() {
                    if w <= v {
                        continue;
                    }
                    if adj[u].contains(&w) {
                        let trio_degree = degree[u] + degree[v] + degree[w] - 6;
                        if trio_degree < min_degree {
                            min_degree = trio_degree;
                        }
                    }
                }
            }
        }

        if min_degree == i32::MAX {
            -1
        } else {
            min_degree
        }
    }
}