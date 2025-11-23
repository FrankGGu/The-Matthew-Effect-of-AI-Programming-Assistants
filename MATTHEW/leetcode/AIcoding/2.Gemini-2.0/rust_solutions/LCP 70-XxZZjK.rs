impl Solution {
    pub fn sand_pile(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut grid = grid;
        let m = grid.len();
        let n = grid[0].len();

        loop {
            let mut stable = true;
            let mut updates = vec![vec![0; n]; m];

            for i in 0..m {
                for j in 0..n {
                    if grid[i][j] > 3 {
                        stable = false;
                        updates[i][j] -= grid[i][j];
                        if i > 0 {
                            updates[i - 1][j] += grid[i][j] / 4;
                        }
                        if i < m - 1 {
                            updates[i + 1][j] += grid[i][j] / 4;
                        }
                        if j > 0 {
                            updates[i][j - 1] += grid[i][j] / 4;
                        }
                        if j < n - 1 {
                            updates[i][j + 1] += grid[i][j] / 4;
                        }
                    }
                }
            }

            if stable {
                break;
            }

            for i in 0..m {
                for j in 0..n {
                    grid[i][j] += updates[i][j];
                    if i > 0 {
                        grid[i][j] += updates[i-1][j].min(0).abs() / 4;
                    }
                     if i < m - 1 {
                        grid[i][j] += updates[i+1][j].min(0).abs() / 4;
                    }
                    if j > 0 {
                        grid[i][j] += updates[i][j-1].min(0).abs() / 4;
                    }
                    if j < n - 1 {
                        grid[i][j] += updates[i][j+1].min(0).abs() / 4;
                    }
                }
            }

            for i in 0..m {
                for j in 0..n {
                     if grid[i][j] > 3 {
                        let count = grid[i][j] / 4;
                         grid[i][j] -= count * 4;
                         if i > 0 {
                             grid[i-1][j] += count;
                         }
                         if i < m - 1 {
                             grid[i+1][j] += count;
                         }
                         if j > 0 {
                             grid[i][j-1] += count;
                         }
                         if j < n - 1 {
                             grid[i][j+1] += count;
                         }
                     }
                }
            }

        }

        grid
    }
}