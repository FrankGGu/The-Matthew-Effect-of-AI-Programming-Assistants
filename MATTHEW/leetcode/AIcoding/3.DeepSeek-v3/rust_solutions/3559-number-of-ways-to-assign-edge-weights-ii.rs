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

    fn union(&mut self, x: usize, y: usize) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x == root_y {
            return;
        }
        if self.size[root_x] < self.size[root_y] {
            self.parent[root_x] = root_y;
            self.size[root_y] += self.size[root_x];
        } else {
            self.parent[root_y] = root_x;
            self.size[root_x] += self.size[root_y];
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

        let mut val_to_nodes = HashMap::new();
        for (i, &val) in vals.iter().enumerate() {
            val_to_nodes.entry(val).or_insert(vec![]).push(i);
        }

        let mut sorted_vals: Vec<_> = val_to_nodes.keys().cloned().collect();
        sorted_vals.sort();

        let mut uf = UnionFind::new(n);
        let mut res = 0;

        for &val in sorted_vals.iter() {
            let nodes = val_to_nodes.get(&val).unwrap();
            for &u in nodes.iter() {
                for &v in adj[u].iter() {
                    if vals[v] <= vals[u] {
                        uf.union(u, v);
                    }
                }
            }

            let mut root_counts = HashMap::new();
            for &u in nodes.iter() {
                *root_counts.entry(uf.find(u)).or_insert(0) += 1;
            }

            for &count in root_counts.values() {
                res += count * (count + 1) / 2;
            }
        }

        res
    }
}