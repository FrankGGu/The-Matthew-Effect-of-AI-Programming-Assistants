impl Solution {
    pub fn maximum_score_after_applying_operations(values: Vec<i32>, edges: Vec<Vec<i32>>) -> i64 {
        let n = values.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        fn dfs(node: usize, parent: usize, adj: &Vec<Vec<usize>>, values: &Vec<i32>) -> (i64, i64) {
            let mut take = values[node] as i64;
            let mut skip = 0;

            if adj[node].len() == 1 && adj[node][0] == parent {
                return (take, skip);
            }

            for &child in &adj[node] {
                if child != parent {
                    let (child_take, child_skip) = dfs(child, node, adj, values);
                    take += child_skip;
                    skip += child_take.max(child_skip);
                }
            }

            (take, skip)
        }

        let (take, skip) = dfs(0, n, &adj, &values);
        take.max(skip)
    }
}