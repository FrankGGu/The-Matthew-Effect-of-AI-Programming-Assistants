use std::collections::{HashMap, HashSet};

pub struct Solution;

impl Solution {
    pub fn sum_of_distances_in_tree(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut count = vec![1; n as usize];
        let mut res = vec![0; n as usize];

        fn dfs1(node: i32, parent: i32, graph: &Vec<Vec<i32>>, res: &mut Vec<i32>, count: &mut Vec<i32>) {
            for &neighbor in &graph[node as usize] {
                if neighbor != parent {
                    dfs1(neighbor, node, graph, res, count);
                    count[node as usize] += count[neighbor as usize];
                    res[node as usize] += res[neighbor as usize] + count[neighbor as usize];
                }
            }
        }

        fn dfs2(node: i32, parent: i32, graph: &Vec<Vec<i32>>, res: &mut Vec<i32>, count: &Vec<i32>, n: i32) {
            for &neighbor in &graph[node as usize] {
                if neighbor != parent {
                    res[neighbor as usize] = res[node as usize] - count[neighbor as usize] + (n - count[neighbor as usize]);
                    dfs2(neighbor, node, graph, res, count, n);
                }
            }
        }

        dfs1(0, -1, &graph, &mut res, &mut count);
        dfs2(0, -1, &graph, &mut res, &count, n);

        res
    }
}