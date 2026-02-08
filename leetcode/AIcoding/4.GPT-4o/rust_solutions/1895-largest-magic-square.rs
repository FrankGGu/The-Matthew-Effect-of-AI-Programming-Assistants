impl Solution {
    pub fn largest_magic_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut sum = vec![vec![0; n + 1]; m + 1];
        let mut max_size = 1;

        for i in 0..m {
            for j in 0..n {
                sum[i + 1][j + 1] = sum[i][j + 1] + sum[i + 1][j] - sum[i][j] + grid[i][j];
            }
        }

        for size in 1..=std::cmp::min(m, n) {
            for i in 0..=m - size {
                for j in 0..=n - size {
                    let s = sum[i + size][j + size] - sum[i][j + size] - sum[i + size][j] + sum[i][j];
                    let expected_sum = size * (size * (size + 1) / 2);
                    if s == expected_sum {
                        let mut valid = true;
                        for k in 0..size {
                            let row_sum: i32 = (0..size).map(|l| grid[i + k][j + l]).sum();
                            let col_sum: i32 = (0..size).map(|l| grid[i + l][j + k]).sum();
                            if row_sum != expected_sum || col_sum != expected_sum {
                                valid = false;
                                break;
                            }
                        }
                        if valid {
                            max_size = size;
                        }
                    }
                }
            }
        }
        max_size
    }
}