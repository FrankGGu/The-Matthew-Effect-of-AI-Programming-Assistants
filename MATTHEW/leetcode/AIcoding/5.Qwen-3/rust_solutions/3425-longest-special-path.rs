impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn longest_special_path(n: i32, edges: Vec<Vec<i32>>, labels: Vec<char>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut max_length = 0;

        fn dfs(
            node: usize,
            parent: usize,
            graph: &Vec<Vec<usize>>,
            labels: &[char],
            visited: &mut Vec<bool>,
            max_length: &mut i32,
        ) {
            visited[node] = true;
            let mut max1 = 0;
            let mut max2 = 0;

            for &neighbor in graph[node].iter() {
                if neighbor == parent || labels[neighbor] != labels[node] {
                    continue;
                }

                dfs(neighbor, node, graph, labels, visited, max_length);

                let length = 1 + *max_length;
                if length > max1 {
                    max2 = max1;
                    max1 = length;
                } else if length > max2 {
                    max2 = length;
                }
            }

            *max_length = std::cmp::max(*max_length, max1 + max2);
        }

        for i in 0..n {
            if !visited[i] {
                dfs(i, usize::MAX, &graph, &labels, &mut visited, &mut max_length);
            }
        }

        max_length
    }
}
}