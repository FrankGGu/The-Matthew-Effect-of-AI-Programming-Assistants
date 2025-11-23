struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU { parent, size }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            if self.size[root_x] < self.size[root_y] {
                self.parent[root_x] = root_y;
                self.size[root_y] += self.size[root_x];
            } else {
                self.parent[root_y] = root_x;
                self.size[root_x] += self.size[root_y];
            }
        }
    }
}

impl Solution {
    pub fn min_edge_weight_equilibrium_queries(
        n: i32,
        edges: Vec<Vec<i32>>,
        queries: Vec<Vec<i32>>,
    ) -> Vec<i32> {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![Vec::new(); n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut depth = vec![0; n];
        let mut parent = vec![vec![0; 15]; n];
        let mut weight_sum = vec![vec![0; 15]; n];

        fn dfs(
            u: usize,
            p: usize,
            d: i32,
            adj: &Vec<Vec<(usize, i32)>>,
            depth: &mut Vec<i32>,
            parent: &mut Vec<Vec<usize>>,
            weight_sum: &mut Vec<Vec<i32>>,
        ) {
            depth[u] = d;
            parent[u][0] = p;

            for &(v, w) in &adj[u] {
                if v != p {
                    weight_sum[v][0] = w;
                    dfs(v, u, d + 1, adj, depth, parent, weight_sum);
                }
            }
        }

        dfs(0, 0, 0, &adj, &mut depth, &mut parent, &mut weight_sum);

        for j in 1..15 {
            for i in 0..n {
                parent[i][j] = parent[parent[i][j - 1]][j - 1];
                weight_sum[i][j] = weight_sum[i][j - 1] + weight_sum[parent[i][j - 1]][j - 1];
            }
        }

        let lca = |mut u: usize, mut v: usize| -> (usize, i32) {
            let mut sum = 0;
            if depth[u] < depth[v] {
                std::mem::swap(&mut u, &mut v);
            }

            let diff = depth[u] - depth[v];
            for i in 0..15 {
                if (diff >> i) & 1 == 1 {
                    sum += weight_sum[u][i];
                    u = parent[u][i];
                }
            }

            if u == v {
                return (u, sum);
            }

            for i in (0..15).rev() {
                if parent[u][i] != parent[v][i] {
                    sum += weight_sum[u][i];
                    sum += weight_sum[v][i];
                    u = parent[u][i];
                    v = parent[v][i];
                }
            }

            (parent[u][0], sum + weight_sum[u][0] + weight_sum[v][0])
        };

        let mut ans = Vec::new();
        for query in &queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            let w = query[2];

            let (lca_node, total_weight) = lca(u, v);
            let dist = depth[u] + depth[v] - 2 * depth[lca_node];
            ans.push(dist - (total_weight / w) as i32);
        }

        ans
    }
}