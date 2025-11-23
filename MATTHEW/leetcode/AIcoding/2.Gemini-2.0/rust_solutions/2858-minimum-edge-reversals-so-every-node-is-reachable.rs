use std::collections::VecDeque;

impl Solution {
    pub fn min_edge_reversals(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push((v, 0));
            adj[v].push((u, 1));
        }

        let mut ans = vec![0; n];

        fn bfs(start: usize, adj: &Vec<Vec<(usize, i32)>>) -> i32 {
            let n = adj.len();
            let mut dist = vec![-1; n];
            let mut q = VecDeque::new();
            q.push_back(start);
            dist[start] = 0;
            let mut cost = 0;

            while let Some(u) = q.pop_front() {
                for &(v, w) in &adj[u] {
                    if dist[v] == -1 {
                        dist[v] = dist[u] + 1;
                        cost += w;
                        q.push_back(v);
                    }
                }
            }
            cost
        }

        ans[0] = bfs(0, &adj);

        fn dfs(u: usize, p: usize, adj: &Vec<Vec<(usize, i32)>>, ans: &mut Vec<i32>) {
            for &(v, w) in &adj[u] {
                if v != p {
                    ans[v] = ans[u] + (if w == 0 { 1 } else { -1 });
                    dfs(v, u, adj, ans);
                }
            }
        }

        dfs(0, 0, &adj, &mut ans);

        ans
    }
}