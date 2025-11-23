impl Solution {

use std::collections::{HashMap, VecDeque};

struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        Self {
            parent: (0..n).collect(),
            rank: vec![1; n],
        }
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
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else {
            self.parent[root_y] = root_x;
            if self.rank[root_x] == self.rank[root_y] {
                self.rank[root_x] += 1;
            }
        }
    }
}

fn are_connected(n: i32, threshold: i32, queries: Vec<Vec<i32>>) -> Vec<bool> {
    let n = n as usize;
    let threshold = threshold as usize;

    let mut uf = UnionFind::new(n);

    for i in (threshold + 1)..n {
        for j in (i * 2)..n {
            uf.union(i, j);
        }
    }

    let mut result = Vec::new();
    for q in queries {
        let u = q[0] as usize;
        let v = q[1] as usize;
        result.push(uf.find(u) == uf.find(v));
    }

    result
}
}