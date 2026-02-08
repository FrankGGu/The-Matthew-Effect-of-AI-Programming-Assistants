struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n).collect(),
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

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_i] = root_j;
        }
    }
}

impl Solution {
    pub fn assign_elements_to_groups_with_constraints(
        n: i32,
        same_group_constraints: Vec<Vec<i32>>,
        diff_group_constraints: Vec<Vec<i32>>,
    ) -> bool {
        let n_usize = n as usize;
        let mut uf = UnionFind::new(n_usize);

        for constraint in same_group_constraints {
            let u = constraint[0] as usize;
            let v = constraint[1] as usize;
            uf.union(u, v);
        }

        for constraint in diff_group_constraints {
            let u = constraint[0] as usize;
            let v = constraint[1] as usize;
            if uf.find(u) == uf.find(v) {
                return false;
            }
        }

        true
    }
}