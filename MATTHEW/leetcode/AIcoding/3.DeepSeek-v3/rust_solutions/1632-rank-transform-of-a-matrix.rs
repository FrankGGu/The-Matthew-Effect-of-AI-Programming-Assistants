use std::collections::{HashMap, BTreeMap};
use std::cmp::max;

struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        UnionFind {
            parent: (0..size).collect(),
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
        if root_x != root_y {
            self.parent[root_y] = root_x;
        }
    }
}

impl Solution {
    pub fn matrix_rank_transform(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = matrix.len();
        if m == 0 {
            return vec![];
        }
        let n = matrix[0].len();
        let mut value_positions = BTreeMap::new();
        for i in 0..m {
            for j in 0..n {
                let val = matrix[i][j];
                value_positions.entry(val).or_insert(vec![]).push((i, j));
            }
        }

        let mut rank = vec![0; m + n];
        let mut res = vec![vec![0; n]; m];
        for (val, positions) in value_positions {
            let mut uf = UnionFind::new(m + n);
            let mut rank_copy = rank.clone();
            for &(i, j) in &positions {
                let root_i = uf.find(i);
                let root_j = uf.find(j + m);
                if root_i != root_j {
                    uf.union(root_i, root_j);
                    rank_copy[root_i] = max(rank_copy[root_i], rank_copy[root_j]);
                }
            }
            for &(i, j) in &positions {
                let root = uf.find(i);
                let new_rank = rank_copy[root] + 1;
                res[i][j] = new_rank;
                rank[i] = new_rank;
                rank[j + m] = new_rank;
            }
        }
        res
    }
}