impl Solution {

use std::cmp::max;

impl Solution {
    pub fn largest_magic_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut max_size = 1;

        for i in 0..m {
            for j in 0..n {
                for k in 0..m {
                    for l in 0..n {
                        if i <= k && j <= l {
                            let size = (k - i + 1).min(l - j + 1);
                            if size < max_size {
                                continue;
                            }
                            let mut is_magic = true;
                            let sum = grid[i][j];
                            for x in i+1..=k {
                                if grid[x][j] != sum {
                                    is_magic = false;
                                    break;
                                }
                            }
                            for y in j+1..=l {
                                if grid[i][y] != sum {
                                    is_magic = false;
                                    break;
                                }
                            }
                            if !is_magic {
                                continue;
                            }
                            let row_sum = sum;
                            for x in i..=k {
                                let mut row_total = 0;
                                for y in j..=l {
                                    row_total += grid[x][y];
                                }
                                if row_total != row_sum {
                                    is_magic = false;
                                    break;
                                }
                            }
                            if !is_magic {
                                continue;
                            }
                            let col_sum = sum;
                            for y in j..=l {
                                let mut col_total = 0;
                                for x in i..=k {
                                    col_total += grid[x][y];
                                }
                                if col_total != col_sum {
                                    is_magic = false;
                                    break;
                                }
                            }
                            if is_magic {
                                max_size = max(max_size, k - i + 1);
                            }
                        }
                    }
                }
            }
        }

        max_size as i32
    }
}
}