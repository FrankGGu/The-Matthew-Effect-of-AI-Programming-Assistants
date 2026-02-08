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
    pub fn latest_day_to_cross(row: i32, col: i32, cells: Vec<Vec<i32>>) -> i32 {
        let row = row as usize;
        let col = col as usize;
        let n = row * col;
        let mut uf = UnionFind::new(n + 2);
        let mut grid = vec![vec![0; col]; row];
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        for day in (0..cells.len()).rev() {
            let i = (cells[day][0] - 1) as usize;
            let j = (cells[day][1] - 1) as usize;
            grid[i][j] = 1;
            let idx = i * col + j + 1;

            if i == 0 {
                uf.union(0, idx);
            }
            if i == row - 1 {
                uf.union(n + 1, idx);
            }

            for (di, dj) in directions.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < row as i32 && nj >= 0 && nj < col as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if grid[ni][nj] == 1 {
                        let nidx = ni * col + nj + 1;
                        uf.union(idx, nidx);
                    }
                }
            }

            if uf.find(0) == uf.find(n + 1) {
                return day as i32;
            }
        }

        0
    }
}