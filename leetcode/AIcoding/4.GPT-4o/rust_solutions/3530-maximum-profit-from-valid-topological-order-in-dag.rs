use std::collections::{HashMap, HashSet};

pub fn maximum_profit(n: i32, edges: Vec<Vec<i32>>, prices: Vec<i32>) -> i32 {
    let mut graph = vec![vec![]; n as usize];
    let mut in_degree = vec![0; n as usize];

    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        in_degree[edge[1] as usize] += 1;
    }

    let mut dp = vec![0; n as usize];
    let mut queue = std::collections::VecDeque::new();

    for i in 0..n {
        if in_degree[i as usize] == 0 {
            queue.push_back(i);
            dp[i as usize] = prices[i as usize];
        }
    }

    while let Some(node) = queue.pop_front() {
        for &neighbor in &graph[node as usize] {
            dp[neighbor as usize] = dp[neighbor as usize].max(dp[node as usize] + prices[neighbor as usize]);
            in_degree[neighbor as usize] -= 1;
            if in_degree[neighbor as usize] == 0 {
                queue.push_back(neighbor);
            }
        }
    }

    *dp.iter().max().unwrap()
}