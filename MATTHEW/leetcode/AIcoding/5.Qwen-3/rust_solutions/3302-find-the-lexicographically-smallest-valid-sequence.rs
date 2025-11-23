impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_lexicographical_valid_sequence(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
        }

        for i in 0..n {
            graph[i].sort();
        }

        let mut result = vec![0; n];
        let mut visited = vec![false; n];

        fn dfs(
            node: usize,
            visited: &mut Vec<bool>,
            graph: &[Vec<usize>],
            result: &mut Vec<i32>,
            index: usize,
        ) -> bool {
            if index == result.len() {
                return true;
            }

            result[index] = node as i32;
            visited[node] = true;

            for &neighbor in &graph[node] {
                if !visited[neighbor] {
                    if dfs(neighbor, visited, graph, result, index + 1) {
                        return true;
                    }
                }
            }

            visited[node] = false;
            false
        }

        for i in 0..n {
            if dfs(i, &mut visited, &graph, &mut result, 0) {
                return result;
            }
        }

        vec![]
    }
}
}