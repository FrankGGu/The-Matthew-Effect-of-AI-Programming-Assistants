use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn count_sub_trees(n: i32, edges: Vec<Vec<i32>>, labels: String) -> Vec<i32> {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1] as usize);
            graph[edge[1] as usize].push(edge[0] as usize);
        }

        let mut result = vec![0; n as usize];
        let labels: Vec<char> = labels.chars().collect();
        let mut visited = vec![false; n as usize];

        fn dfs(node: usize, graph: &Vec<Vec<usize>>, labels: &Vec<char>, visited: &mut Vec<bool>, result: &mut Vec<i32>, count: &mut Vec<i32>) {
            visited[node] = true;
            let mut label_count = vec![0; 26];

            for &neighbor in &graph[node] {
                if !visited[neighbor] {
                    dfs(neighbor, graph, labels, visited, result, count);
                    for i in 0..26 {
                        label_count[i] += count[neighbor][i];
                    }
                }
            }

            label_count[(labels[node] as usize - 'a' as usize)] += 1;
            result[node] = label_count[(labels[node] as usize - 'a' as usize)] as i32;
            count[node] = label_count;
        }

        let mut count = vec![vec![0; 26]; n as usize];
        dfs(0, &graph, &labels, &mut visited, &mut result, &mut count);
        result
    }
}