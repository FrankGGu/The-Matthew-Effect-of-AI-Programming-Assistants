impl Solution {
    pub fn min_flips(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut ans = i32::MAX;

        for mask in 0..(1 << m) {
            let mut temp_grid = grid.clone();
            let mut flips = 0;

            for i in 0..m {
                if (mask >> i) & 1 == 1 {
                    flips += 1;
                    for j in 0..n {
                        temp_grid[i][j] = 1 - temp_grid[i][j];
                    }
                }
            }

            let mut is_palindrome = true;
            for i in 0..m {
                for j in 0..(n / 2) {
                    if temp_grid[i][j] != temp_grid[i][n - 1 - j] {
                        is_palindrome = false;
                        break;
                    }
                }
                if !is_palindrome {
                    break;
                }
            }

            if is_palindrome {
                ans = ans.min(flips);
            }
        }

        if ans == i32::MAX {
            -1
        } else {
            ans
        }
    }
}