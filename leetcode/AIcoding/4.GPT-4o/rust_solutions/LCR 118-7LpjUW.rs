struct UnionFind {
    parent: Vec<i32>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        Self {
            parent: (0..n as i32).collect(),
        }
    }

    fn find(&mut self, x: i32) -> i32 {
        if self.parent[x as usize] != x {
            self.parent[x as usize] = self.find(self.parent[x as usize]);
        }
        self.parent[x as usize]
    }

    fn union(&mut self, x: i32, y: i32) -> bool {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x == root_y {
            return false;
        }
        self.parent[root_x as usize] = root_y;
        true
    }
}

impl Solution {
    pub fn find_redundant_directed_edge(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();
        let mut union_find = UnionFind::new(n + 1);
        let mut edge_to_remove = vec![];

        for edge in edges.iter() {
            if !union_find.union(edge[0], edge[1]) {
                edge_to_remove = edge.clone();
            }
        }

        if edge_to_remove.is_empty() {
            return vec![];
        }

        let mut parent = vec![0; n + 1];
        for edge in edges.iter() {
            parent[edge[1] as usize] += 1;
        }

        for edge in edges.iter() {
            if edge == &edge_to_remove {
                continue;
            }
            if parent[edge[1] as usize] == 1 {
                return edge_to_remove;
            }
        }

        edge_to_remove
    }
}