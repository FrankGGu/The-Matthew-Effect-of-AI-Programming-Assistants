struct Dsu {
    parent: Vec<usize>,
    num_components: usize,
}

impl Dsu {
    fn new(n: usize) -> Self {
        Dsu {
            parent: (0..n).collect(),
            num_components: n,
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            let root = self.find(self.parent[i]);
            self.parent[i] = root;
            root
        }
    }

    // Returns true if i and j were in different components and are now united.
    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            self.parent[root_i] = root_j;
            self.num_components -= 1;
            true
        } else {
            false
        }
    }
}

struct Solution;

impl Solution {
    pub fn max_num_edges_to_remove(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut dsu_alice = Dsu::new(n_usize);
        let mut dsu_bob = Dsu::new(n_usize);
        let mut kept_edges = 0;

        // Sort edges by type in descending order (type 3 first, then 2, then 1)
        let mut sorted_edges = edges;
        sorted_edges.sort_by(|a, b| b[0].cmp(&a[0]));

        for edge in sorted_edges {
            let edge_type = edge[0];
            let u = (edge[1] - 1) as usize; // Convert to 0-indexed
            let v = (edge[2] - 1) as usize; // Convert to 0-indexed

            match edge_type {
                3 => {
                    let united_alice = dsu_alice.union(u, v);
                    let united_bob = dsu_bob.union(u, v);
                    if united_alice || united_bob {
                        kept_edges += 1;
                    }
                }
                1 => {
                    if dsu_alice.union(u, v) {
                        kept_edges += 1;
                    }
                }
                2 => {
                    if dsu_bob.union(u, v) {
                        kept_edges += 1;
                    }
                }
                _ => unreachable!(), // Problem constraints specify edge types are 1, 2, or 3
            }
        }

        if dsu_alice.num_components > 1 || dsu_bob.num_components > 1 {
            -1
        } else {
            (edges.len() - kept_edges) as i32
        }
    }
}