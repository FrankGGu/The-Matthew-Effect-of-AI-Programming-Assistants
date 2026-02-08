struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            size: vec![1; n],
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                self.parent[root_i] = root_j;
                self.size[root_j] += self.size[root_i];
            } else {
                self.parent[root_j] = root_i;
                self.size[root_i] += self.size[root_j];
            }
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn check_paths(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n_usize = n as usize;
        let mut dsu = DSU::new(n_usize);

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            dsu.union(u, v);
        }

        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            results.push(dsu.find(u) == dsu.find(v));
        }

        results
    }
}