use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let mut degree = vec![0; n + 1];
        let mut edge_count = HashMap::new();

        for edge in edges {
            let u = edge[0].min(edge[1]) as usize;
            let v = edge[0].max(edge[1]) as usize;
            degree[u] += 1;
            degree[v] += 1;
            *edge_count.entry((u, v)).or_insert(0) += 1;
        }

        let mut sorted_degree = degree[1..].to_vec();
        sorted_degree.sort_unstable();

        let mut res = Vec::new();
        for q in queries {
            let mut count = 0;
            let q = *q;
            let mut left = 0;
            let mut right = n - 1;
            while left < right {
                if sorted_degree[left] + sorted_degree[right] > q {
                    count += (right - left) as i32;
                    right -= 1;
                } else {
                    left += 1;
                }
            }

            for (&(u, v), &cnt) in &edge_count {
                let sum = degree[u] + degree[v];
                if sum > q && sum - cnt <= q {
                    count -= 1;
                }
            }
            res.push(count);
        }
        res
    }
}