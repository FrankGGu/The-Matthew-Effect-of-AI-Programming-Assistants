impl Solution {
    pub fn regions_by_slashes(grid: Vec<String>) -> i32 {
        let n = grid.len();
        let mut parent: Vec<usize> = (0..4 * n * n).collect();

        for i in 0..n {
            for j in 0..n {
                let idx = 4 * (i * n + j);
                let c = grid[i].chars().nth(j).unwrap();

                match c {
                    ' ' => {
                        Self::union(&mut parent, idx, idx + 1);
                        Self::union(&mut parent, idx + 1, idx + 2);
                        Self::union(&mut parent, idx + 2, idx + 3);
                    }
                    '/' => {
                        Self::union(&mut parent, idx, idx + 3);
                        Self::union(&mut parent, idx + 1, idx + 2);
                    }
                    '\\' => {
                        Self::union(&mut parent, idx, idx + 1);
                        Self::union(&mut parent, idx + 2, idx + 3);
                    }
                    _ => {}
                }

                if i > 0 {
                    Self::union(&mut parent, idx, idx - 4 * n + 2);
                }
                if j > 0 {
                    Self::union(&mut parent, idx + 3, idx - 4 + 1);
                }
            }
        }

        let mut res = 0;
        for i in 0..4 * n * n {
            if Self::find(&mut parent, i) == i {
                res += 1;
            }
        }
        res
    }

    fn find(parent: &mut Vec<usize>, x: usize) -> usize {
        if parent[x] != x {
            parent[x] = Self::find(parent, parent[x]);
        }
        parent[x]
    }

    fn union(parent: &mut Vec<usize>, x: usize, y: usize) {
        let root_x = Self::find(parent, x);
        let root_y = Self::find(parent, y);
        if root_x != root_y {
            parent[root_x] = root_y;
        }
    }
}