struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        UnionFind {
            parent: (0..size).collect(),
            rank: vec![0; size],
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
        let x_root = self.find(x);
        let y_root = self.find(y);
        if x_root == y_root {
            return;
        }
        if self.rank[x_root] < self.rank[y_root] {
            self.parent[x_root] = y_root;
        } else {
            self.parent[y_root] = x_root;
            if self.rank[x_root] == self.rank[y_root] {
                self.rank[x_root] += 1;
            }
        }
    }
}

impl Solution {
    pub fn distance_limited_paths_exist(n: i32, edge_list: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut edge_list = edge_list;
        let mut queries: Vec<_> = queries.into_iter().enumerate().map(|(i, q)| (q[0] as usize, q[1] as usize, q[2], i)).collect();

        edge_list.sort_by(|a, b| a[2].cmp(&b[2]));
        queries.sort_by(|a, b| a.2.cmp(&b.2));

        let mut uf = UnionFind::new(n);
        let mut res = vec![false; queries.len()];
        let mut edge_idx = 0;

        for (u, v, limit, idx) in queries {
            while edge_idx < edge_list.len() && edge_list[edge_idx][2] < limit {
                let u_edge = edge_list[edge_idx][0] as usize;
                let v_edge = edge_list[edge_idx][1] as usize;
                uf.union(u_edge, v_edge);
                edge_idx += 1;
            }
            res[idx] = uf.find(u) == uf.find(v);
        }

        res
    }
}