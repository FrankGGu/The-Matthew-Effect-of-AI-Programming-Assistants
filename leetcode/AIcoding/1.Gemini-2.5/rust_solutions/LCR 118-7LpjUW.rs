struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n + 1];
        for i in 0..=n {
            parent[i] = i;
        }
        DSU { parent }
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
            self.parent[root_i] = root_j;
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn find_redundant_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();
        let mut dsu = DSU::new(n);

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;

            if !dsu.union(u, v) {
                return edge;
            }
        }
        unreachable!()
    }
}