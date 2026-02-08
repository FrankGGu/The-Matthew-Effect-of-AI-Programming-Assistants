impl Solution {
    pub fn bicycle_yard(edges: Vec<Vec<i32>>, start_node: i32, target_node: i32, k: i32) -> i32 {
        let n = 1001;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
        }

        let mut dp: Vec<Vec<i32>> = vec![vec![-1; 51]; n];
        dp[start_node as usize][0] = 0;

        for i in 1..=k {
            for u in 0..n {
                if dp[u][i - 1] == -1 {
                    continue;
                }
                for &(v, w) in &adj[u] {
                    if dp[v][i as usize] == -1 || dp[v][i as usize] > dp[u][i - 1] + w {
                        dp[v][i as usize] = dp[u][i - 1] + w;
                    }
                }
            }
        }

        if dp[target_node as usize][k as usize] == -1 || dp[target_node as usize][k as usize] % 2 != 0 {
            return -1;
        }

        dp[target_node as usize][k as usize]
    }
}