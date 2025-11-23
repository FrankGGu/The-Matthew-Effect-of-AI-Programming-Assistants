impl Solution {

use std::collections::{HashMap, VecDeque};

struct Solution;

impl Solution {
    pub fn min_total_price(n: i32, roads: Vec<Vec<i32>>, trips: Vec<Vec<i32>>, price: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut count = vec![0; n];
        let mut visited = vec![false; n];

        for trip in trips {
            let start = trip[0] as usize;
            let end = trip[1] as usize;
            let mut path = vec![];
            Self::dfs(start, end, &graph, &mut visited, &mut path);
            for &node in &path {
                count[node] += 1;
            }
        }

        let mut dp = vec![0; n];
        let mut visited = vec![false; n];
        Self::post_order(0, &graph, &mut visited, &mut dp, &count, &price);

        dp[0]
    }

    fn dfs(
        start: usize,
        end: usize,
        graph: &[Vec<usize>],
        visited: &mut Vec<bool>,
        path: &mut Vec<usize>,
    ) -> bool {
        visited[start] = true;
        path.push(start);
        if start == end {
            return true;
        }
        for &neighbor in &graph[start] {
            if !visited[neighbor] {
                if Self::dfs(neighbor, end, graph, visited, path) {
                    return true;
                }
            }
        }
        path.pop();
        false
    }

    fn post_order(
        node: usize,
        graph: &[Vec<usize>],
        visited: &mut Vec<bool>,
        dp: &mut Vec<i32>,
        count: &[i32],
        price: &[i32],
    ) {
        visited[node] = true;
        for &child in &graph[node] {
            if !visited[child] {
                Self::post_order(child, graph, visited, dp, count, price);
                dp[node] += dp[child];
            }
        }
        dp[node] += count[node] * price[node];
    }
}
}