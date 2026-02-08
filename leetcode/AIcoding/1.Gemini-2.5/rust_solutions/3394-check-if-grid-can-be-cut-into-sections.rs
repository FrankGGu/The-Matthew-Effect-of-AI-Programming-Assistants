struct Solution;

impl Solution {
    pub fn is_cuttable(grid: Vec<Vec<i32>>) -> bool {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut prefix_sum_ones = vec![vec![0; cols + 1]; rows + 1];
        for r in 0..rows {
            for c in 0..cols {
                prefix_sum_ones[r + 1][c + 1] = grid[r][c]
                    + prefix_sum_ones[r][c + 1]
                    + prefix_sum_ones[r + 1][c]
                    - prefix_sum_ones[r][c];
            }
        }

        let mut memo = vec![
            vec![vec![vec![None; cols]; rows]; cols];
            rows
        ];

        struct DFS<'a> {
            prefix_sum_ones: &'a Vec<Vec<i32>>,
            memo: &'a mut Vec<Vec<Vec<Vec<Option<bool>>>>>,
        }

        impl<'a> DFS<'a> {
            fn is_monochromatic(&self, r1: usize, c1: usize, r2: usize, c2: usize) -> bool {
                let total_cells = (r2 - r1 + 1) * (c2 - c1 + 1);
                let ones_count = self.prefix_sum_ones[r2 + 1][c2 + 1]
                    - self.prefix_sum_ones[r1][c2 + 1]
                    - self.prefix_sum_ones[r2 + 1][c1]
                    + self.prefix_sum_ones[r1][c1];
                ones_count == 0 || ones_count == total_cells as i32
            }

            fn solve(&mut self, r1: usize, c1: usize, r2: usize, c2: usize) -> bool {
                if let Some(res) = self.memo[r1][c1][r2][c2] {
                    return res;
                }

                if self.is_monochromatic(r1, c1, r2, c2) {
                    self.memo[r1][c1][r2][c2] = Some(true);
                    return true;
                }

                for r_cut in r1..r2 {
                    if self.solve(r1, c1, r_cut, c2) && self.solve(r_cut + 1, c1, r2, c2) {
                        self.memo[r1][c1][r2][c2] = Some(true);
                        return true;
                    }
                }

                for c_cut in c1..c2 {
                    if self.solve(r1, c1, r2, c_cut) && self.solve(r1, c_cut + 1, r2, c2) {
                        self.memo[r1][c1][r2][c2] = Some(true);
                        return true;
                    }
                }

                self.memo[r1][c1][r2][c2] = Some(false);
                false
            }
        }

        let mut dfs_solver = DFS {
            prefix_sum_ones: &prefix_sum_ones,
            memo: &mut memo,
        };

        dfs_solver.solve(0, 0, rows - 1, cols - 1)
    }
}