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
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x == root_y {
            return false;
        }
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else {
            self.parent[root_y] = root_x;
            if self.rank[root_x] == self.rank[root_y] {
                self.rank[root_x] += 1;
            }
        }
        true
    }
}

impl Solution {
    pub fn make_connected(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        if connections.len() < n - 1 {
            return -1;
        }
        let mut uf = UnionFind::new(n);
        let mut redundant = 0;
        for conn in connections {
            let x = conn[0] as usize;
            let y = conn[1] as usize;
            if !uf.union(x, y) {
                redundant += 1;
            }
        }
        let mut components = 0;
        for i in 0..n {
            if uf.find(i) == i {
                components += 1;
            }
        }
        if redundant >= components - 1 {
            components - 1
        } else {
            -1
        }
    }
}