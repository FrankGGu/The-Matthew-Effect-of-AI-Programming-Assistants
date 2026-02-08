struct UnionFind {
    parent: Vec<usize>,
    count: usize,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n).collect(),
            count: n,
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            let root = self.find(self.parent[i]);
            self.parent[i] = root;
            root
        }
    }

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            self.parent[root_j] = root_i;
            self.count -= 1;
        }
    }
}

impl Solution {
    pub fn make_connected(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;

        if connections.len() < n_usize - 1 {
            return -1;
        }

        let mut uf = UnionFind::new(n_usize);

        for conn in connections {
            let u = conn[0] as usize;
            let v = conn[1] as usize;
            uf.union(u, v);
        }

        (uf.count - 1) as i32
    }
}