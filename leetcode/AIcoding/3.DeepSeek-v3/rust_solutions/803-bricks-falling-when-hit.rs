struct UnionFind {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let parent = (0..n).collect();
        let size = vec![1; n];
        UnionFind { parent, size }
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
    pub fn hit_bricks(grid: Vec<Vec<i32>>, hits: Vec<Vec<i32>>) -> Vec<i32> {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut grid = grid;
        let mut res = vec![0; hits.len()];
        let mut uf = UnionFind::new(rows * cols + 1);
        let top = rows * cols;

        for hit in &hits {
            let i = hit[0] as usize;
            let j = hit[1] as usize;
            if grid[i][j] == 1 {
                grid[i][j] = 2;
            }
        }

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    let idx = i * cols + j;
                    if i == 0 {
                        uf.union(idx, top);
                    }
                    if i > 0 && grid[i - 1][j] == 1 {
                        uf.union(idx, (i - 1) * cols + j);
                    }
                    if j > 0 && grid[i][j - 1] == 1 {
                        uf.union(idx, i * cols + j - 1);
                    }
                }
            }
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        for k in (0..hits.len()).rev() {
            let i = hits[k][0] as usize;
            let j = hits[k][1] as usize;
            if grid[i][j] == 2 {
                let mut count = 0;
                let idx = i * cols + j;
                let prev_top_size = uf.size[uf.find(top)];
                if i == 0 {
                    uf.union(idx, top);
                }
                for dir in &dirs {
                    let ni = i as i32 + dir.0;
                    let nj = j as i32 + dir.1;
                    if ni >= 0 && ni < rows as i32 && nj >= 0 && nj < cols as i32 {
                        let ni = ni as usize;
                        let nj = nj as usize;
                        if grid[ni][nj] == 1 {
                            uf.union(idx, ni * cols + nj);
                        }
                    }
                }
                let new_top_size = uf.size[uf.find(top)];
                if new_top_size > prev_top_size {
                    res[k] = (new_top_size - prev_top_size - 1) as i32;
                }
                grid[i][j] = 1;
            }
        }

        res
    }
}