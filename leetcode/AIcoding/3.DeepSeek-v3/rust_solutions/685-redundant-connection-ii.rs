struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        UnionFind {
            parent: (0..size).collect(),
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
            false
        } else {
            self.parent[root_y] = root_x;
            true
        }
    }
}

impl Solution {
    pub fn find_redundant_directed_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();
        let mut parent = vec![0; n + 1];
        let mut candidates = Vec::new();

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            if parent[v] != 0 {
                candidates.push(vec![parent[v] as i32, v as i32]);
                candidates.push(edge.clone());
            } else {
                parent[v] = u as i32;
            }
        }

        let mut uf = UnionFind::new(n + 1);
        if candidates.is_empty() {
            for edge in edges {
                let u = edge[0] as usize;
                let v = edge[1] as usize;
                if !uf.union(u, v) {
                    return edge;
                }
            }
        } else {
            for edge in &edges {
                if edge == &candidates[0] {
                    continue;
                }
                let u = edge[0] as usize;
                let v = edge[1] as usize;
                if !uf.union(u, v) {
                    return candidates[1].clone();
                }
            }
        }
        candidates[0].clone()
    }
}