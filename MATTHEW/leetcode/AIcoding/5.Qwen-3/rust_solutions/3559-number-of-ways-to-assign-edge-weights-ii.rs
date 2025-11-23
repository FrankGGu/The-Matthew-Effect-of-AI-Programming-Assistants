impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn number_of_ways(edges: Vec<Vec<i32>>) -> i64 {
        let n = edges.len() as i32 + 1;
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n as usize];
        let mut subtree_sizes = vec![0; n as usize];
        let mut result = 1;

        fn dfs(u: usize, parent: usize, graph: &Vec<Vec<usize>>, visited: &mut Vec<bool>, subtree_sizes: &mut Vec<i32>) -> i32 {
            visited[u] = true;
            subtree_sizes[u] = 1;
            for &v in &graph[u] {
                if v != parent {
                    subtree_sizes[u] += dfs(v, u, graph, visited, subtree_sizes);
                }
            }
            subtree_sizes[u]
        }

        dfs(0, 0, &graph, &mut visited, &mut subtree_sizes);

        let mut freq = HashMap::new();
        for &size in &subtree_sizes {
            *freq.entry(size).or_insert(0) += 1;
        }

        for (&count, _) in &freq {
            if count > 1 {
                result = (result as i64) * (count as i64 - 1) % 1_000_000_007;
            }
        }

        result
    }
}
}