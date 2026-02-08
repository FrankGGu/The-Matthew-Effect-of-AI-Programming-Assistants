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

        let mut parent = vec![0; n];
        let mut xor = vec![0; n];
        let mut in_time = vec![0; n];
        let mut out_time = vec![0; n];
        let mut time = 0;

        Self::dfs(0, n, &adj, &mut parent, &nums, &mut xor, &mut in_time, &mut out_time, &mut time);

        let mut res = std::i32::MAX;
        for i in 1..n {
            for j in i + 1..n {
                let (a, b) = if Self::is_ancestor(i, j, &in_time, &out_time) {
                    (j, i)
                } else if Self::is_ancestor(j, i, &in_time, &out_time) {
                    (i, j)
                } else {
                    (i, j)
                };

                let x = if Self::is_ancestor(a, b, &in_time, &out_time) {
                    xor[b]
                } else {
                    xor[a]
                };
                let y = if Self::is_ancestor(a, b, &in_time, &out_time) {
                    xor[b] ^ xor[a]
                } else {
                    xor[a] ^ xor[b]
                };
                let z = xor[0] ^ x ^ y;
                let max = x.max(y).max(z);
                let min = x.min(y).min(z);
                res = res.min(max - min);
            }
        }
        res
    }

    fn dfs(u: usize, p: usize, adj: &Vec<Vec<usize>>, parent: &mut Vec<usize>, nums: &Vec<i32>, xor: &mut Vec<i32>, in_time: &mut Vec<i32>, out_time: &mut Vec<i32>, time: &mut i32) {
        parent[u] = p;
        *time += 1;
        in_time[u] = *time;
        xor[u] = nums[u];
        for &v in &adj[u] {
            if v != p {
                Self::dfs(v, u, adj, parent, nums, xor, in_time, out_time, time);
                xor[u] ^= xor[v];
            }
        }
        *time += 1;
        out_time[u] = *time;
    }

    fn is_ancestor(u: usize, v: usize, in_time: &Vec<i32>, out_time: &Vec<i32>) -> bool {
        in_time[u] <= in_time[v] && out_time[u] >= out_time[v]
    }
}