use std::collections::HashMap;

struct DSU {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            rank: vec![0; n],
        }
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
            if self.rank[root_x] < self.rank[root_y] {
                self.parent[root_x] = root_y;
            } else if self.rank[root_x] > self.rank[root_y] {
                self.parent[root_y] = root_x;
            } else {
                self.parent[root_y] = root_x;
                self.rank[root_x] += 1;
            }
        }
    }
}

impl Solution {
    pub fn matrix_rank_transform(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut ans = vec![vec![0; n]; m];
        let mut rank = vec![0; m + n];

        let mut cells = Vec::new();
        for i in 0..m {
            for j in 0..n {
                cells.push((matrix[i][j], i, j));
            }
        }
        cells.sort();

        let mut i = 0;
        while i < cells.len() {
            let start = i;
            let mut dsu = DSU::new(m + n);
            let mut components = HashMap::new();

            while i < cells.len() && cells[i].0 == cells[start].0 {
                let (_, row, col) = cells[i];
                dsu.union(row, m + col);
                i += 1;
            }

            for j in start..i {
                let (_, row, col) = cells[j];
                let root = dsu.find(row);
                components.entry(root).or_insert(0);
            }

            let mut new_rank = rank.clone();
            for (root, _) in components.iter_mut() {
                let mut max_rank = 0;
                for j in start..i {
                    let (_, row, col) = cells[j];
                    if dsu.find(row) == *root {
                        max_rank = max_rank.max(rank[row].max(rank[m + col]));
                    }
                }
                *components.get_mut(root).unwrap() = max_rank + 1;
            }

            for j in start..i {
                let (_, row, col) = cells[j];
                let root = dsu.find(row);
                let r = *components.get(&root).unwrap();
                ans[row][col] = r;
                new_rank[row] = new_rank[row].max(r);
                new_rank[m + col] = new_rank[m + col].max(r);
            }

            rank = new_rank;
        }

        ans
    }
}