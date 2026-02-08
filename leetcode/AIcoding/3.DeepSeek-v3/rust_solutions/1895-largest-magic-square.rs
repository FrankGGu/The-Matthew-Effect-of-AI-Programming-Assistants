impl Solution {
    pub fn largest_magic_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut row_sum = vec![vec![0; n + 1]; m];
        let mut col_sum = vec![vec![0; m + 1]; n];

        for i in 0..m {
            for j in 0..n {
                row_sum[i][j + 1] = row_sum[i][j] + grid[i][j];
                col_sum[j][i + 1] = col_sum[j][i] + grid[i][j];
            }
        }

        let mut max_k = 1;

        for i in 0..m {
            for j in 0..n {
                let max_possible_k = std::cmp::min(m - i, n - j);
                for k in (max_k + 1..=max_possible_k).rev() {
                    if k <= max_k {
                        break;
                    }
                    let mut diag_sum = 0;
                    let mut anti_diag_sum = 0;
                    let mut valid = true;

                    for d in 0..k {
                        diag_sum += grid[i + d][j + d];
                        anti_diag_sum += grid[i + d][j + k - 1 - d];
                    }

                    if diag_sum != anti_diag_sum {
                        continue;
                    }

                    let target = diag_sum;

                    for r in 0..k {
                        let sum = row_sum[i + r][j + k] - row_sum[i + r][j];
                        if sum != target {
                            valid = false;
                            break;
                        }
                    }

                    if !valid {
                        continue;
                    }

                    for c in 0..k {
                        let sum = col_sum[j + c][i + k] - col_sum[j + c][i];
                        if sum != target {
                            valid = false;
                            break;
                        }
                    }

                    if valid {
                        max_k = k;
                        break;
                    }
                }
            }
        }

        max_k as i32
    }
}