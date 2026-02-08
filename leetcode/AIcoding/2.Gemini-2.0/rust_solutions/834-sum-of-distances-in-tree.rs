impl Solution {
    pub fn sum_of_distances_in_tree(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut count: Vec<i32> = vec![1; n];
        let mut ans: Vec<i32> = vec![0; n];

        fn dfs(node: usize, parent: usize, adj: &Vec<Vec<usize>>, count: &mut Vec<i32>, ans: &mut Vec<i32>) {
            for &child in &adj[node] {
                if child != parent {
                    dfs(child, node, adj, count, ans);
                    count[node] += count[child];
                    ans[node] += ans[child] + count[child];
                }
            }
        }

        dfs(0, n, &adj, &mut count, &mut ans);

        fn dfs2(node: usize, parent: usize, adj: &Vec<Vec<usize>>, count: &Vec<i32>, ans: &mut Vec<i32>, n: usize) {
            for &child in &adj[node] {
                if child != parent {
                    ans[child] = ans[node] - count[child] + (n as i32) - count[child];
                    dfs2(child, node, adj, count, ans, n);
                }
            }
        }

        dfs2(0, n, &adj, &count, &mut ans, n);

        ans
    }
}