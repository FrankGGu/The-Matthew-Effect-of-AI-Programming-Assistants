impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn sum_distances_in_tree(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut res = vec![0; n];
        let mut count = vec![1; n];

        fn dfs(node: usize, parent: usize, graph: &Vec<Vec<usize>>, count: &mut Vec<i32>, res: &mut Vec<i32>) {
            for &child in &graph[node] {
                if child != parent {
                    dfs(child, node, graph, count, res);
                    count[node] += count[child];
                    res[node] += res[child] + count[child];
                }
            }
        }

        fn dfs2(node: usize, parent: usize, graph: &Vec<Vec<usize>>, count: &mut Vec<i32>, res: &mut Vec<i32>) {
            for &child in &graph[node] {
                if child != parent {
                    res[child] = res[node] - count[child] + (n as i32 - count[child]);
                    dfs2(child, node, graph, count, res);
                }
            }
        }

        dfs(0, 0, &graph, &mut count, &mut res);
        dfs2(0, 0, &graph, &mut count, &mut res);
        res
    }
}
}