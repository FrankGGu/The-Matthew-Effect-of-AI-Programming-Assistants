struct DSU {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU {
            parent,
            rank: vec![0; n],
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
            return false;
        }
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else if self.rank[root_x] > self.rank[root_y] {
            self.parent[root_y] = root_x;
        } else {
            self.parent[root_y] = root_x;
            self.rank[root_x] += 1;
        }
        true
    }
}

impl Solution {
    pub fn max_num_edges_to_remove(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut dsu_alice = DSU::new(n + 1);
        let mut dsu_bob = DSU::new(n + 1);
        let mut removed_edges = 0;
        let mut connected_alice = 0;
        let mut connected_bob = 0;

        for edge in &edges {
            if edge[0] == 3 {
                let u = edge[1] as usize;
                let v = edge[2] as usize;
                if dsu_alice.union(u, v) {
                    dsu_bob.union(u, v);
                    connected_alice += 1;
                    connected_bob += 1;
                } else {
                    removed_edges += 1;
                }
            }
        }

        for edge in &edges {
            if edge[0] == 1 {
                let u = edge[1] as usize;
                let v = edge[2] as usize;
                if dsu_alice.union(u, v) {
                    connected_alice += 1;
                } else {
                    removed_edges += 1;
                }
            } else if edge[0] == 2 {
                let u = edge[1] as usize;
                let v = edge[2] as usize;
                if dsu_bob.union(u, v) {
                    connected_bob += 1;
                } else {
                    removed_edges += 1;
                }
            }
        }

        if connected_alice != n - 1 || connected_bob != n - 1 {
            return -1;
        }

        removed_edges
    }
}