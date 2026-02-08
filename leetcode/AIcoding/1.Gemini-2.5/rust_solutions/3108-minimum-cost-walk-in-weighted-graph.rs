struct DSU {
    parent: Vec<usize>,
    cost: Vec<i32>, // Stores the bitwise AND of all edge weights in the component
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            cost: vec![-1; n], // Initialize with -1 (all bits set, 0xFFFFFFFF)
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            return i;
        }
        let root = self.find(self.parent[i]);
        self.parent[i] = root;
        root
    }

    fn union(&mut self, i: usize, j: usize, weight: i32) {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            self.parent[root_j] = root_i;
            self.cost[root_i] &= self.cost[root_j];
            self.cost[root_i] &= weight;
        } else {
            self.cost[root_i] &= weight;
        }
    }
}

impl Solution {
    pub fn minimum_cost(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n_usize = n as usize;
        let mut dsu = DSU::new(n_usize);

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            dsu.union(u, v, w);
        }

        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let from = query[0] as usize;
            let to = query[1] as usize;

            if from == to {
                results.push(0);
                continue;
            }

            let root_from = dsu.find(from);
            let root_to = dsu.find(to);

            if root_from == root_to {
                results.push(dsu.cost[root_from]);
            } else {
                results.push(-1); 
            }
        }
        results
    }
}