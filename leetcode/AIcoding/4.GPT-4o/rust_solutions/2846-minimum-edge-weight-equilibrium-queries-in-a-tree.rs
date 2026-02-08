use std::collections::{HashMap, HashSet};

pub struct Solution {}

impl Solution {
    pub fn min_edge_weight_equilibrium_queries(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph = vec![Vec::new(); n as usize];
        for edge in edges {
            graph[edge[0] as usize].push((edge[1], edge[2]));
            graph[edge[1] as usize].push((edge[0], edge[2]));
        }

        let mut answer = vec![-1; queries.len()];
        let mut max_edge = vec![0; n as usize];
        let mut visited = vec![false; n as usize];

        fn dfs(node: usize, max_weight: i32, graph: &Vec<Vec<(i32, i32)>>, visited: &mut Vec<bool>, max_edge: &mut Vec<i32>) {
            visited[node] = true;
            for &(neighbor, weight) in &graph[node] {
                if !visited[neighbor as usize] {
                    max_edge[neighbor as usize] = max_edge[node] + weight.max(max_weight);
                    dfs(neighbor as usize, weight.max(max_weight), graph, visited, max_edge);
                }
            }
        }

        visited[0] = true;
        for &(neighbor, weight) in &graph[0] {
            max_edge[neighbor as usize] = weight;
            dfs(neighbor as usize, weight, &graph, &mut visited, &mut max_edge);
        }

        for (i, query) in queries.iter().enumerate() {
            let (x, y) = (query[0] as usize, query[1] as usize);
            answer[i] = max_edge[x].min(max_edge[y]);
        }

        answer
    }
}