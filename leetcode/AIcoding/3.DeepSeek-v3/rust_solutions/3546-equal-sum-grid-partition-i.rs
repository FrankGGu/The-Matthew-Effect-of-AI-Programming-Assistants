impl Solution {
    pub fn can_partition_grid(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut total = 0;
        let mut rows = vec![0; m];
        let mut cols = vec![0; n];

        for i in 0..m {
            for j in 0..n {
                total += grid[i][j];
                rows[i] += grid[i][j];
                cols[j] += grid[i][j];
            }
        }

        if total % 4 != 0 {
            return false;
        }
        let target = total / 4;

        let mut row_sums = vec![0; m + 1];
        for i in 0..m {
            row_sums[i + 1] = row_sums[i] + rows[i];
        }

        let mut col_sums = vec![0; n + 1];
        for j in 0..n {
            col_sums[j + 1] = col_sums[j] + cols[j];
        }

        for i in 1..m {
            if row_sums[i] == target {
                for j in i + 1..m {
                    if row_sums[j] == 2 * target {
                        for k in j + 1..m {
                            if row_sums[k] == 3 * target {
                                return true;
                            }
                        }
                    }
                }
            }
        }

        for j in 1..n {
            if col_sums[j] == target {
                for k in j + 1..n {
                    if col_sums[k] == 2 * target {
                        for l in k + 1..n {
                            if col_sums[l] == 3 * target {
                                return true;
                            }
                        }
                    }
                }
            }
        }

        false
    }
}