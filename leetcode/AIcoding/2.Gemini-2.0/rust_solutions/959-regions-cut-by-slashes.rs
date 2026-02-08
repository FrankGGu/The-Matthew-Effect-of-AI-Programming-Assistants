struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU { parent, size }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
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
        }
    }
}

impl Solution {
    pub fn regions_by_slashes(grid: Vec<String>) -> i32 {
        let n = grid.len();
        let mut dsu = DSU::new(4 * n * n);
        for i in 0..n {
            let row = grid[i].as_bytes();
            for j in 0..n {
                let idx = i * n + j;
                if row[j] == b'/' {
                    dsu.union(4 * idx + 0, 4 * idx + 3);
                    dsu.union(4 * idx + 1, 4 * idx + 2);
                } else if row[j] == b'\\' {
                    dsu.union(4 * idx + 0, 4 * idx + 1);
                    dsu.union(4 * idx + 2, 4 * idx + 3);
                } else {
                    dsu.union(4 * idx + 0, 4 * idx + 1);
                    dsu.union(4 * idx + 1, 4 * idx + 2);
                    dsu.union(4 * idx + 2, 4 * idx + 3);
                }

                if i > 0 {
                    dsu.union(4 * idx + 0, 4 * (idx - n) + 2);
                }
                if i < n - 1 {
                    dsu.union(4 * idx + 2, 4 * (idx + n) + 0);
                }
                if j > 0 {
                    dsu.union(4 * idx + 3, 4 * (idx - 1) + 1);
                }
                if j < n - 1 {
                    dsu.union(4 * idx + 1, 4 * (idx + 1) + 3);
                }
            }
        }

        let mut count = 0;
        for i in 0..4 * n * n {
            if dsu.find(i) == i {
                count += 1;
            }
        }
        count
    }
}