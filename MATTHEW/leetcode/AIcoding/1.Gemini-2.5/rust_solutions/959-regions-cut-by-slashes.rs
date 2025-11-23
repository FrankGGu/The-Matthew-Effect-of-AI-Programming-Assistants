struct DSU {
    parent: Vec<usize>,
    count: usize,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            count: n,
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

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_i] = root_j;
            self.count -= 1;
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn regions_by_slashes(grid: Vec<String>) -> i32 {
        let n = grid.len();
        if n == 0 {
            return 0;
        }

        let total_nodes = n * n * 4;
        let mut dsu = DSU::new(total_nodes);

        let get_idx = |r: usize, c: usize, k: usize| -> usize {
            (r * n + c) * 4 + k
        };

        for r in 0..n {
            for c in 0..n {
                match grid[r].as_bytes()[c] as char {
                    ' ' => {
                        dsu.union(get_idx(r, c, 0), get_idx(r, c, 1));
                        dsu.union(get_idx(r, c, 1), get_idx(r, c, 2));
                        dsu.union(get_idx(r, c, 2), get_idx(r, c, 3));
                    }
                    '/' => {
                        dsu.union(get_idx(r, c, 0), get_idx(r, c, 3));
                        dsu.union(get_idx(r, c, 1), get_idx(r, c, 2));
                    }
                    '\\' => {
                        dsu.union(get_idx(r, c, 0), get_idx(r, c, 1));
                        dsu.union(get_idx(r, c, 2), get_idx(r, c, 3));
                    }
                    _ => {}
                }

                if c + 1 < n {
                    dsu.union(get_idx(r, c, 1), get_idx(r, c + 1, 3));
                }

                if r + 1 < n {
                    dsu.union(get_idx(r, c, 2), get_idx(r + 1, c, 0));
                }
            }
        }

        dsu.count as i32
    }
}