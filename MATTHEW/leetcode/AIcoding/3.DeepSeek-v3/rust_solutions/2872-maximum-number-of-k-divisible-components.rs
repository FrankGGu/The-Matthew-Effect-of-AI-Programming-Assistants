use std::collections::VecDeque;

impl Solution {
    pub fn max_k_divisible_components(n: i32, edges: Vec<Vec<i32>>, values: Vec<i32>, k: i32) -> i32 {
        let n = n as usize;
        let k = k as i64;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut parent = vec![usize::MAX; n];
        let mut children = vec![vec![]; n];
        let mut queue = VecDeque::new();
        queue.push_back(0);
        parent[0] = 0;

        while let Some(u) = queue.pop_front() {
            for &v in &adj[u] {
                if parent[v] == usize::MAX {
                    parent[v] = u;
                    children[u].push(v);
                    queue.push_back(v);
                }
            }
        }

        let mut sum = vec![0i64; n];
        let mut res = 0;

        for u in (0..n).rev() {
            sum[u] = values[u] as i64;
            for &v in &children[u] {
                sum[u] += sum[v];
            }
            if sum[u] % k == 0 {
                res += 1;
            }
        }

        res
    }
}