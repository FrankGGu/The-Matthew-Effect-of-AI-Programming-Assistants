use std::collections::BinaryHeap;
use std::cmp::Reverse;

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

    fn union(&mut self, x: usize, y: usize) -> bool {
        let x_root = self.find(x);
        let y_root = self.find(y);
        if x_root == y_root {
            return false;
        }
        if self.rank[x_root] < self.rank[y_root] {
            self.parent[x_root] = y_root;
        } else {
            self.parent[y_root] = x_root;
            if self.rank[x_root] == self.rank[y_root] {
                self.rank[x_root] += 1;
            }
        }
        true
    }
}

impl Solution {
    pub fn min_max_edge_weight(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut heap = BinaryHeap::new();
        for edge in edges {
            heap.push(Reverse((edge[2], edge[0] as usize, edge[1] as usize)));
        }
        let mut uf = UnionFind::new(n);
        let mut res = 0;
        while let Some(Reverse((w, u, v))) = heap.pop() {
            if uf.union(u, v) {
                res = res.max(w);
            }
        }
        res
    }
}