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

impl Solution {
    pub fn remove_stones(stones: Vec<Vec<i32>>) -> i32 {
        let n = stones.len();
        let mut uf = UnionFind::new(n);
        let mut rows = std::collections::HashMap::new();
        let mut cols = std::collections::HashMap::new();

        for (i, stone) in stones.iter().enumerate() {
            let x = stone[0];
            let y = stone[1];
            if let Some(&prev_row) = rows.get(&x) {
                uf.union(prev_row, i);
            }
            if let Some(&prev_col) = cols.get(&y) {
                uf.union(prev_col, i);
            }
            rows.insert(x, i);
            cols.insert(y, i);
        }

        let mut roots = std::collections::HashSet::new();
        for i in 0..n {
            roots.insert(uf.find(i));
        }

        (n - roots.len()) as i32
    }
}