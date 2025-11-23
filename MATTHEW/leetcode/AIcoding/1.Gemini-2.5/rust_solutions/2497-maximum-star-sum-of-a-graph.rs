use std::collections::HashMap;

impl Solution {
    pub fn max_star_sum(vals: Vec<i32>, edges: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = vals.len();
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v as i32);
            adj[v].push(u as i32);
        }

        let mut max_star_sum = i32::MIN;

        for i in 0..n {
            max_star_sum = max_star_sum.max(vals[i]);
        }

        for i in 0..n {
            let current_center_val = vals[i];
            let mut positive_neighbor_vals: Vec<i32> = Vec::new();

            for &neighbor_idx_i32 in &adj[i] {
                let neighbor_idx = neighbor_idx_i32 as usize;
                if vals[neighbor_idx] > 0 {
                    positive_neighbor_vals.push(vals[neighbor_idx]);
                }
            }

            positive_neighbor_vals.sort_unstable_by(|a, b| b.cmp(a));

            let mut current_star_sum = current_center_val;
            let num_to_add = (k as usize).min(positive_neighbor_vals.len());

            for j in 0..num_to_add {
                current_star_sum += positive_neighbor_vals[j];
            }

            max_star_sum = max_star_sum.max(current_star_sum);
        }

        max_star_sum
    }
}