use std::collections::{BTreeMap, HashMap};

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
    pub fn number_of_good_paths(vals: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = vals.len();
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut val_to_nodes = BTreeMap::new();
        for (i, &val) in vals.iter().enumerate() {
            val_to_nodes.entry(val).or_insert(vec![]).push(i);
        }

        let mut uf = UnionFind::new(n);
        let mut res = 0;

        for (&val, nodes) in val_to_nodes.iter() {
            for &u in nodes {
                for &v in adj[u].iter() {
                    if vals[v] <= val {
                        uf.union(u, v);
                    }
                }
            }

            let mut root_counts = HashMap::new();
            for &u in nodes {
                *root_counts.entry(uf.find(u)).or_insert(0) += 1;
            }

            for &count in root_counts.values() {
                res += count * (count + 1) / 2;
            }
        }

        res
    }
}