use std::collections::{HashMap, HashSet};

struct UnionFind {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let parent = (0..n).collect();
        let size = vec![1; n];
        UnionFind { parent, size }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) -> usize {
        let x_root = self.find(x);
        let y_root = self.find(y);
        if x_root == y_root {
            return self.size[x_root];
        }
        if self.size[x_root] < self.size[y_root] {
            self.parent[x_root] = y_root;
            self.size[y_root] += self.size[x_root];
            self.size[y_root]
        } else {
            self.parent[y_root] = x_root;
            self.size[x_root] += self.size[y_root];
            self.size[x_root]
        }
    }
}

impl Solution {
    pub fn max_weight(edges: Vec<Vec<i32>>, mut weight: Vec<i32>) -> i32 {
        let n = weight.len();
        let mut edge_list = Vec::new();
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = weight[u] + weight[v];
            edge_list.push((w, u, v));
        }
        edge_list.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut uf = UnionFind::new(n);
        let mut res = 0;
        for (w, u, v) in edge_list {
            let size_u = uf.size[uf.find(u)];
            let size_v = uf.size[uf.find(v)];
            res += w * (size_u * size_v) as i32;
            uf.union(u, v);
        }
        res
    }
}