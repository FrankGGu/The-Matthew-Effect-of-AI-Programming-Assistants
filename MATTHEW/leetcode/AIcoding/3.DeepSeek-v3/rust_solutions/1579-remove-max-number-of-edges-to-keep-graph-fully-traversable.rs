struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        UnionFind {
            parent: (0..size).collect(),
            rank: vec![0; size],
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) -> bool {
        let x_root = self.find(x);
        let y_root = self.find(y);
        if x_root == y_root {
            return false;
        }
        if self.rank[x_root] < self.rank[y_root] {
            self.parent[x_root] = y_root;
        } else if self.rank[x_root] > self.rank[y_root] {
            self.parent[y_root] = x_root;
        } else {
            self.parent[y_root] = x_root;
            self.rank[x_root] += 1;
        }
        true
    }
}

impl Solution {
    pub fn max_num_edges_to_remove(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut alice = UnionFind::new(n + 1);
        let mut bob = UnionFind::new(n + 1);
        let mut edges = edges;
        edges.sort_by(|a, b| b[0].cmp(&a[0]));
        let mut used = 0;

        for edge in edges {
            let t = edge[0];
            let u = edge[1] as usize;
            let v = edge[2] as usize;
            if t == 3 {
                let a = alice.union(u, v);
                let b = bob.union(u, v);
                if a || b {
                    used += 1;
                }
            } else if t == 1 {
                if alice.union(u, v) {
                    used += 1;
                }
            } else if t == 2 {
                if bob.union(u, v) {
                    used += 1;
                }
            }
        }

        let mut alice_connected = true;
        let mut bob_connected = true;
        let root = alice.find(1);
        for i in 2..=n {
            if alice.find(i) != root {
                alice_connected = false;
                break;
            }
        }
        let root = bob.find(1);
        for i in 2..=n {
            if bob.find(i) != root {
                bob_connected = false;
                break;
            }
        }

        if alice_connected && bob_connected {
            (edges.len() as i32) - used
        } else {
            -1
        }
    }
}