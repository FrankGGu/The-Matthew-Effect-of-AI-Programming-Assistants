impl Solution {
    pub fn largest_magic_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut row_prefix_sums = vec![vec![0i64; n + 1]; m];
        for i in 0..m {
            for j in 0..n {
                row_prefix_sums[i][j + 1] = row_prefix_sums[i][j] + grid[i][j] as i64;
            }
        }

        let mut col_prefix_sums = vec![vec![0i64; n]; m + 1];
        for j in 0..n {
            for i in 0..m {
                col_prefix_sums[i + 1][j] = col_prefix_sums[i][j] + grid[i][j] as i64;
            }
        }

        for k in (1..=m.min(n)).rev() {
            for r in 0..=(m - k) {
                for c in 0..=(n - k) {
                    let target_sum = row_prefix_sums[r][c + k] - row_prefix_sums[r][c];

                    let mut is_magic = true;

                    for i in r + 1..r + k {
                        if (row_prefix_sums[i][c + k] - row_prefix_sums[i][c]) != target_sum {
                            is_magic = false;
                            break;
                        }
                    }
                    if !is_magic {
                        continue;
                    }

                    for j in c..c + k {
                        if (col_prefix_sums[r + k][j] - col_prefix_sums[r][j]) != target_sum {
                            is_magic = false;
                            break;
                        }
                    }
                    if !is_magic {
                        continue;
                    }

                    let mut diag_sum1 = 0i64;
                    for i in 0..k {
                        diag_sum1 += grid[r + i][c + i] as i64;
                    }
                    if diag_sum1 != target_sum {
                        is_magic = false;
                    }
                    if !is_magic {
                        continue;
                    }

                    let mut diag_sum2 = 0i64;
                    for i in 0..k {
                        diag_sum2 += grid[r + i][c + k - 1 - i] as i64;
                    }
                    if diag_sum2 != target_sum {
                        is_magic = false;
                    }
                    if !is_magic {
                        continue;
                    }

                    return k as i32;
                }
            }
        }

        1
    }
}