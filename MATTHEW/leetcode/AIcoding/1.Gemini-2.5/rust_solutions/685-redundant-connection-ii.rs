struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            return i;
        }
        self.parent[i] = self.find(self.parent[i]);
        self.parent[i]
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
    pub fn find_redundant_directed_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();

        let mut parent_map: Vec<i32> = vec![0; n + 1];
        let mut candidate1: Vec<i32> = Vec::new();
        let mut candidate2: Vec<i32> = Vec::new();

        for edge in &edges {
            let u = edge[0];
            let v = edge[1];

            if parent_map[v as usize] != 0 {
                candidate1 = vec![parent_map[v as usize], v];
                candidate2 = vec![u, v];
            } else {
                parent_map[v as usize] = u;
            }
        }

        if !candidate1.is_empty() {
            let mut dsu = DSU::new(n + 1);
            for edge in &edges {
                let u = edge[0] as usize;
                let v = edge[1] as usize;

                if edge[0] == candidate2[0] && edge[1] == candidate2[1] {
                    continue;
                }

                if !dsu.union(u, v) {
                    return candidate1;
                }
            }
            return candidate2;
        }

        let mut dsu = DSU::new(n + 1);
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;

            if !dsu.union(u, v) {
                return edge.clone();
            }
        }

        vec![] 
    }
}