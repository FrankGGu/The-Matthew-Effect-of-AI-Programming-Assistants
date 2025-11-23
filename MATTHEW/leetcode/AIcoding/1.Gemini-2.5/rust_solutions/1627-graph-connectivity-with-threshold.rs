struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let parent = (0..n).collect();
        let size = vec![1; n];
        DSU { parent, size }
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
    pub fn are_connected(n: i32, threshold: i32, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n_usize = n as usize;
        let threshold_usize = threshold as usize;

        let mut dsu = DSU::new(n_usize + 1);

        for f in (threshold_usize + 1)..=n_usize {
            for multiple_idx in 2.. {
                let multiple = f * multiple_idx;
                if multiple > n_usize {
                    break;
                }
                dsu.union(f, multiple);
            }
        }

        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let city1 = query[0] as usize;
            let city2 = query[1] as usize;
            results.push(dsu.find(city1) == dsu.find(city2));
        }

        results
    }
}