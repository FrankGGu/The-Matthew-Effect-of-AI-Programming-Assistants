use std::collections::HashSet;

struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        let parent = (0..size).collect();
        let rank = vec![0; size];
        UnionFind { parent, rank }
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
    pub fn count_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut uf = UnionFind::new(n);
        for edge in edges {
            let x = edge[0] as usize;
            let y = edge[1] as usize;
            uf.union(x, y);
        }
        let mut roots = HashSet::new();
        for i in 0..n {
            roots.insert(uf.find(i));
        }
        roots.len() as i32
    }
}