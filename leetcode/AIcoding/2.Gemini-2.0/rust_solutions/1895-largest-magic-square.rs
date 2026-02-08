impl Solution {
    pub fn largest_magic_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut max_k = 1;

        for k in (2..=std::cmp::min(m, n)).rev() {
            for r in 0..=m - k {
                for c in 0..=n - k {
                    if Self::is_magic_square(&grid, r, c, k) {
                        max_k = k as i32;
                        return max_k;
                    }
                }
            }
        }

        max_k
    }

    fn is_magic_square(grid: &Vec<Vec<i32>>, r: usize, c: usize, k: usize) -> bool {
        let mut sum = 0;
        for i in 0..k {
            sum += grid[r][c + i];
        }

        for i in 0..k {
            let mut row_sum = 0;
            for j in 0..k {
                row_sum += grid[r + i][c + j];
            }
            if row_sum != sum {
                return false;
            }
        }

        for j in 0..k {
            let mut col_sum = 0;
            for i in 0..k {
                col_sum += grid[r + i][c + j];
            }
            if col_sum != sum {
                return false;
            }
        }

        let mut diag1_sum = 0;
        for i in 0..k {
            diag1_sum += grid[r + i][c + i];
        }
        if diag1_sum != sum {
            return false;
        }

        let mut diag2_sum = 0;
        for i in 0..k {
            diag2_sum += grid[r + i][c + k - 1 - i];
        }
        if diag2_sum != sum {
            return false;
        }

        true
    }
}