use std::collections::{HashMap, HashSet};

pub struct Solution;

impl Solution {
    pub fn max_weighted_k_edge_path(graph: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut dp = vec![vec![0; k as usize + 1]; graph.len()];
        let n = graph.len();

        for i in 0..n {
            for j in 1..=k {
                for (neigh, weight) in graph[i].iter().enumerate() {
                    if weight > &0 {
                        dp[neigh][j as usize] = dp[neigh][j as usize].max(dp[i][(j - 1) as usize] + weight);
                    }
                }
            }
        }

        let mut max_weight = 0;
        for i in 0..n {
            max_weight = max_weight.max(dp[i][k as usize]);
        }

        max_weight
    }
}