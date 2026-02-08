use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn count_subtrees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph = vec![Vec::new(); n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut result = vec![0; n as usize];
        let mut visited = vec![false; n as usize];

        fn dfs(node: usize, graph: &Vec<Vec<i32>>, visited: &mut Vec<bool>, result: &mut Vec<i32>) -> (i32, i32) {
            visited[node] = true;
            let mut max_depth = 0;
            let mut count = 0;

            for &neighbor in &graph[node] {
                if !visited[neighbor as usize] {
                    let (depth, subtree_count) = dfs(neighbor as usize, graph, visited, result);
                    if depth + 1 > max_depth {
                        max_depth = depth + 1;
                        count = subtree_count;
                    } else if depth + 1 == max_depth {
                        count += subtree_count;
                    }
                }
            }
            result[node] = count + 1;
            (max_depth, result[node])
        }

        dfs(0, &graph, &mut visited, &mut result);
        result
    }
}