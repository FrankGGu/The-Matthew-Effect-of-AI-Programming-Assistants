struct Solution;

impl Solution {
    pub fn max_weighted_k_edge_path(n: i32, edges: Vec<Vec<i32>>, k: i32) -> i64 {
        let n = n as usize;
        let k = k as usize;

        let mut adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i64;
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        const NEG_INF: i64 = i64::MIN / 2;
        let mut dp: Vec<Vec<i64>> = vec![vec![NEG_INF; n]; k + 1];

        for i in 0..n {
            dp[0][i] = 0;
        }

        for current_k in 1..=k {
            for u in 0..n {
                if dp[current_k - 1][u] == NEG_INF {
                    continue;
                }
                for &(v, weight) in &adj[u] {
                    dp[current_k][v] = dp[current_k][v].max(dp[current_k - 1][u] + weight);
                }
            }
        }

        let mut max_weight = NEG_INF;
        for i in 0..n {
            max_weight = max_weight.max(dp[k][i]);
        }

        if max_weight == NEG_INF {
            0
        } else {
            max_weight
        }
    }
}