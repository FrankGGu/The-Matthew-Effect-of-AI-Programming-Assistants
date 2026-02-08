use std::collections::HashSet;

impl Solution {
    pub fn hit_bricks(grid: Vec<Vec<i32>>, hits: Vec<Vec<i32>>) -> Vec<i32> {
        let mut grid = grid;
        let rows = grid.len();
        let cols = grid[0].len();

        for hit in &hits {
            grid[hit[0]][hit[1]] -= 1;
        }

        let mut uf = UnionFind::new(rows * cols + 1);

        for i in 0..cols {
            if grid[0][i] == 1 {
                uf.union(i, rows * cols);
            }
        }

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == 1 {
                    let index = r * cols + c;
                    if r > 0 && grid[r - 1][c] == 1 {
                        uf.union(index, (r - 1) * cols + c);
                    }
                    if c > 0 && grid[r][c - 1] == 1 {
                        uf.union(index, r * cols + c - 1);
                    }
                }
            }
        }

        let mut result = Vec::new();

        for hit in hits.into_iter().rev() {
            let r = hit[0];
            let c = hit[1];
            if grid[r][c] == 0 {
                grid[r][c] = 1;
                let index = r * cols + c;
                let mut count = 0;
                if r == 0 {
                    count += 1;
                    uf.union(index, rows * cols);
                }
                for (dr, dc) in &[(1, 0), (-1, 0), (0, 1), (0, -1)] {
                    let nr = r as isize + dr;
                    let nc = c as isize + dc;
                    if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize && grid[nr as usize][nc as usize] == 1 {
                        count += uf.union(index, nr as usize * cols + nc as usize);
                    }
                }
                if count > 0 {
                    result.push(count - 1);
                } else {
                    result.push(0);
                }
            } else {
                result.push(0);
            }
        }

        result.reverse();
        result
    }
}

struct UnionFind {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n).collect(),
            size: vec![1; n],
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) -> usize {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            if self.size[root_x] < self.size[root_y] {
                self.parent[root_x] = root_y;
                self.size[root_y] += self.size[root_x];
                self.size[root_x] = 0;
            } else {
                self.parent[root_y] = root_x;
                self.size[root_x] += self.size[root_y];
                self.size[root_y] = 0;
            }
            return 1;
        }
        0
    }
}