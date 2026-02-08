struct UnionFind {
    parent: Vec<usize>,
    target_sum: Vec<i32>,
}

impl UnionFind {
    fn new(n: usize, target: &[i32]) -> Self {
        let mut parent = vec![0; n];
        let mut target_sum = vec![0; n];
        for i in 0..n {
            parent[i] = i;
            target_sum[i] = target[i];
        }
        UnionFind { parent, target_sum }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            self.target_sum[root_i] += self.target_sum[root_j];
            self.parent[root_j] = root_i;
        }
    }
}

impl Solution {
    pub fn maximize_the_number_of_target_nodes_after_connecting_trees_ii(
        n: i32,
        edges: Vec<Vec<i32>>,
        target: Vec<i32>,
    ) -> i32 {
        let n_usize = n as usize;
        let mut uf = UnionFind::new(n_usize, &target);

        for edge in edges {
            uf.union(edge[0] as usize, edge[1] as usize);
        }

        let mut component_target_sums: Vec<i32> = Vec::new();
        for i in 0..n_usize {
            if uf.parent[i] == i {
                component_target_sums.push(uf.target_sum[i]);
            }
        }

        component_target_sums.sort_unstable_by(|a, b| b.cmp(a));

        if component_target_sums.is_empty() {
            return 0;
        }

        if component_target_sums.len() == 1 {
            return component_target_sums[0];
        }

        component_target_sums[0] + component_target_sums[1]
    }
}