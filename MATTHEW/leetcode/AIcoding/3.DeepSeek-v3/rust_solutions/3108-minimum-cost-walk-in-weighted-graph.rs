use std::collections::{HashMap, HashSet};

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
        } else if self.rank[x_root] > self.rank[y_root] {
            self.parent[y_root] = x_root;
        } else {
            self.parent[y_root] = x_root;
            self.rank[x_root] += 1;
        }
    }
}

impl Solution {
    pub fn minimum_cost(n: i32, edges: Vec<Vec<i32>>, query: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut uf = UnionFind::new(n);
        let mut cost = vec![!0; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            uf.union(u, v);
            cost[u] &= w;
            cost[v] &= w;
        }

        let mut group_cost = HashMap::new();
        for u in 0..n {
            let root = uf.find(u);
            *group_cost.entry(root).or_insert(!0) &= cost[u];
        }

        let mut res = Vec::new();
        for q in query {
            let u = q[0] as usize;
            let v = q[1] as usize;
            if u == v {
                res.push(0);
                continue;
            }
            if uf.find(u) != uf.find(v) {
                res.push(-1);
            } else {
                res.push(group_cost[&uf.find(u)] as i32);
            }
        }
        res
    }
}