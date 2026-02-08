impl Solution {
    pub fn minimum_score(n: i32, edges: Vec<Vec<i32>>, values: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize - 1;
            let v = edge[1] as usize - 1;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut parent: Vec<usize> = vec![0; n];
        let mut depth: Vec<i32> = vec![0; n];
        let mut subtree_xor: Vec<i32> = vec![0; n];

        fn dfs(
            u: usize,
            p: usize,
            d: i32,
            adj: &Vec<Vec<usize>>,
            values: &Vec<i32>,
            parent: &mut Vec<usize>,
            depth: &mut Vec<i32>,
            subtree_xor: &mut Vec<i32>,
        ) {
            parent[u] = p;
            depth[u] = d;
            subtree_xor[u] = values[u] as i32;

            for &v in &adj[u] {
                if v != p {
                    dfs(v, u, d + 1, adj, values, parent, depth, subtree_xor);
                    subtree_xor[u] ^= subtree_xor[v];
                }
            }
        }

        dfs(0, 0, 0, &adj, &values, &mut parent, &mut depth, &mut subtree_xor);

        let mut ans = i32::MAX;
        for i in 0..edges.len() {
            for j in i + 1..edges.len() {
                let mut u1 = edges[i][0] as usize - 1;
                let mut v1 = edges[i][1] as usize - 1;
                let mut u2 = edges[j][0] as usize - 1;
                let mut v2 = edges[j][1] as usize - 1;

                if depth[u1] < depth[v1] {
                    std::mem::swap(&mut u1, &mut v1);
                }
                if depth[u2] < depth[v2] {
                    std::mem::swap(&mut u2, &mut v2);
                }

                let mut x = 0;
                let mut y = 0;
                let mut z = 0;

                if is_ancestor(v1, v2, &parent) {
                    x = subtree_xor[v2];
                    y = subtree_xor[v1] ^ x;
                    z = subtree_xor[0] ^ subtree_xor[v1];
                } else if is_ancestor(v2, v1, &parent) {
                    x = subtree_xor[v1];
                    y = subtree_xor[v2] ^ x;
                    z = subtree_xor[0] ^ subtree_xor[v2];
                } else {
                    x = subtree_xor[v1];
                    y = subtree_xor[v2];
                    z = subtree_xor[0] ^ x ^ y;
                }

                let mx = x.max(y).max(z);
                let mn = x.min(y).min(z);
                ans = ans.min(mx - mn);
            }
        }

        ans
    }
}

fn is_ancestor(u: usize, v: usize, parent: &Vec<usize>) -> bool {
    let mut curr = v;
    while curr != 0 {
        if curr == u {
            return true;
        }
        curr = parent[curr];
    }
    false
}