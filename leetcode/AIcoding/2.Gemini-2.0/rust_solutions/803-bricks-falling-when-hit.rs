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

    fn size(&mut self, x: usize) -> usize {
        let root_x = self.find(x);
        self.size[root_x]
    }
}

impl Solution {
    pub fn hit_bricks(grid: Vec<Vec<i32>>, hits: Vec<Vec<i32>>) -> Vec<i32> {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut new_grid = grid.clone();

        for hit in &hits {
            new_grid[hit[0] as usize][hit[1] as usize] = 0;
        }

        let mut dsu = DSU::new(rows * cols + 1);

        for i in 0..cols {
            if new_grid[0][i] == 1 {
                dsu.union(i + 1, 0);
            }
        }

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        for i in 0..rows {
            for j in 0..cols {
                if new_grid[i][j] == 1 {
                    for (dx, dy) in directions {
                        let new_row = i as i32 + dx;
                        let new_col = j as i32 + dy;
                        if new_row >= 0 && new_row < rows as i32 && new_col >= 0 && new_col < cols as i32 && new_grid[new_row as usize][new_col as usize] == 1 {
                            dsu.union((i * cols + j + 1) as usize, (new_row as usize * cols + new_col as usize + 1) as usize);
                        }
                    }
                }
            }
        }

        let mut result = vec![0; hits.len()];
        for i in (0..hits.len()).rev() {
            let row = hits[i][0] as usize;
            let col = hits[i][1] as usize;

            if grid[row][col] == 0 {
                continue;
            }

            let before = dsu.size(0);
            new_grid[row][col] = 1;

            if row == 0 {
                dsu.union(col + 1, 0);
            }

            for (dx, dy) in directions {
                let new_row = row as i32 + dx;
                let new_col = col as i32 + dy;
                if new_row >= 0 && new_row < rows as i32 && new_col >= 0 && new_col < cols as i32 && new_grid[new_row as usize][new_col as usize] == 1 {
                    dsu.union((row * cols + col + 1) as usize, (new_row as usize * cols + new_col as usize + 1) as usize);
                }
            }

            let after = dsu.size(0);
            result[i] = (after - before - 1).max(0) as i32;
        }

        result
    }
}