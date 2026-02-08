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

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) -> bool {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            if self.size[root_x] < self.size[root_y] {
                self.parent[root_x] = root_y;
                self.size[root_y] += self.size[root_x];
            } else {
                self.parent[root_y] = root_x;
                self.size[root_x] += self.size[root_y];
            }
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn find_critical_and_pseudo_critical_edges(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut edges_with_index: Vec<(usize, usize, usize, usize)> = edges
            .iter()
            .enumerate()
            .map(|(i, e)| (e[0] as usize, e[1] as usize, e[2] as usize, i))
            .collect();

        edges_with_index.sort_by_key(|&(_, _, weight, _)| weight);

        let mut min_weight = 0;
        let mut dsu = DSU::new(n);
        let mut num_edges = 0;

        for &(u, v, weight, _) in &edges_with_index {
            if dsu.union(u, v) {
                min_weight += weight;
                num_edges += 1;
            }
        }

        let mut critical = Vec::new();
        let mut pseudo_critical = Vec::new();

        for &(u, v, weight, index) in &edges_with_index {
            let mut current_weight = 0;
            let mut dsu_force = DSU::new(n);
            dsu_force.union(u, v);
            current_weight += weight;
            let mut force_edges = 1;

            for &(u2, v2, weight2, _) in &edges_with_index {
                if dsu_force.union(u2, v2) {
                    current_weight += weight2;
                    force_edges += 1;
                }
            }

            if current_weight > min_weight || force_edges < n - 1 {
                critical.push(index as i32);
            } else {
                let mut current_weight2 = 0;
                let mut dsu_skip = DSU::new(n);
                let mut skip_edges = 0;

                for &(u2, v2, weight2, index2) in &edges_with_index {
                    if index2 as usize != index && dsu_skip.union(u2, v2) {
                        current_weight2 += weight2;
                        skip_edges += 1;
                    }
                }

                if current_weight2 == min_weight && skip_edges == n - 1 {
                    pseudo_critical.push(index as i32);
                }
            }
        }

        vec![critical, pseudo_critical]
    }
}