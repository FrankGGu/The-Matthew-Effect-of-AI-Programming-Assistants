struct Solution;

impl Solution {
    pub fn longest_special_path(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
        }

        let mut memo: Vec<i32> = vec![-1; n];

        let mut max_len = 0;
        if n == 0 {
            return 0;
        }

        for i in 0..n {
            max_len = max_len.max(Self::dfs(i, &adj, &mut memo));
        }

        max_len
    }

    fn dfs(u: usize, adj: &Vec<Vec<usize>>, memo: &mut Vec<i32>) -> i32 {
        if memo[u] != -1 {
            return memo[u];
        }

        let mut current_max_len = 1;

        for &v in &adj[u] {
            current_max_len = current_max_len.max(1 + Self::dfs(v, adj, memo));
        }

        memo[u] = current_max_len;
        current_max_len
    }
}