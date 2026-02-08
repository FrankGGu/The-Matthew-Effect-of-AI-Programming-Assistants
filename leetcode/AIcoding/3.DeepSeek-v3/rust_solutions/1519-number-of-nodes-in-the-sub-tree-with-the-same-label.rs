use std::collections::HashMap;

impl Solution {
    pub fn count_sub_trees(n: i32, edges: Vec<Vec<i32>>, labels: String) -> Vec<i32> {
        let n = n as usize;
        let labels = labels.as_bytes();
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut res = vec![0; n];
        Self::dfs(0, n, &adj, labels, &mut res);
        res
    }

    fn dfs(u: usize, parent: usize, adj: &Vec<Vec<usize>>, labels: &[u8], res: &mut Vec<i32>) -> HashMap<u8, i32> {
        let mut count = HashMap::new();
        *count.entry(labels[u]).or_insert(0) += 1;

        for &v in &adj[u] {
            if v != parent {
                let child_count = Self::dfs(v, u, adj, labels, res);
                for (ch, cnt) in child_count {
                    *count.entry(ch).or_insert(0) += cnt;
                }
            }
        }

        res[u] = *count.get(&labels[u]).unwrap();
        count
    }
}