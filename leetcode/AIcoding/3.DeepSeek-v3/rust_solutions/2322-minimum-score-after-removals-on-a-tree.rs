use std::collections::HashSet;

impl Solution {
    pub fn minimum_score(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut adj = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut xor = vec![0; n];
        let mut parent = vec![0; n];
        let mut in_time = vec![0; n];
        let mut out_time = vec![0; n];
        let mut time = 0;
        Self::dfs(0, n, &adj, &nums, &mut xor, &mut parent, &mut in_time, &mut out_time, &mut time);

        let mut res = std::i32::MAX;
        for i in 1..n {
            for j in i + 1..n {
                let (a, b) = if in_time[i] < in_time[j] && out_time[i] >= out_time[j] {
                    (j, i)
                } else if in_time[j] < in_time[i] && out_time[j] >= out_time[i] {
                    (i, j)
                } else {
                    (i, j)
                };

                let x = if in_time[a] < in_time[b] && out_time[a] >= out_time[b] {
                    xor[a]
                } else if in_time[b] < in_time[a] && out_time[b] >= out_time[a] {
                    xor[b]
                } else {
                    xor[0] ^ xor[a] ^ xor[b]
                };
                let y = xor[a] ^ x;
                let z = xor[b] ^ x;
                let max = x.max(y).max(z);
                let min = x.min(y).min(z);
                res = res.min(max - min);
            }
        }
        res
    }

    fn dfs(
        u: usize,
        p: usize,
        adj: &Vec<Vec<usize>>,
        nums: &Vec<i32>,
        xor: &mut Vec<i32>,
        parent: &mut Vec<usize>,
        in_time: &mut Vec<i32>,
        out_time: &mut Vec<i32>,
        time: &mut i32,
    ) {
        parent[u] = p;
        *time += 1;
        in_time[u] = *time;
        xor[u] = nums[u];
        for &v in &adj[u] {
            if v != p {
                Self::dfs(v, u, adj, nums, xor, parent, in_time, out_time, time);
                xor[u] ^= xor[v];
            }
        }
        out_time[u] = *time;
    }
}