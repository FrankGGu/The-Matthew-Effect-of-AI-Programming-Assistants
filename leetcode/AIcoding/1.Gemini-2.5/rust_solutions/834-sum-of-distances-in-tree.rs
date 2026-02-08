struct Solution;

impl Solution {
    pub fn sum_of_distances_in_tree(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut count: Vec<i32> = vec![0; n_usize];
        let mut ans: Vec<i32> = vec![0; n_usize];

        fn dfs1(
            u: usize,
            p: usize,
            adj: &Vec<Vec<usize>>,
            count: &mut Vec<i32>,
            ans: &mut Vec<i32>,
        ) {
            count[u] = 1;
            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                dfs1(v, u, adj, count, ans);
                count[u] += count[v];
                ans[u] += ans[v] + count[v];
            }
        }

        fn dfs2(
            u: usize,
            p: usize,
            adj: &Vec<Vec<usize>>,
            count: &Vec<i32>,
            ans: &mut Vec<i32>,
            n: i32,
        ) {
            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                ans[v] = ans[u] - count[v] + (n - count[v]);
                dfs2(v, u, adj, count, ans, n);
            }
        }

        dfs1(0, n_usize, &adj, &mut count, &mut ans);
        dfs2(0, n_usize, &adj, &count, &mut ans, n);

        ans
    }
}