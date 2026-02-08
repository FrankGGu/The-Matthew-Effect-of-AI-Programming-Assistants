use std::collections::HashMap;

impl Solution {
    pub fn equal_sum_grid_partition(grid: Vec<Vec<i32>>) -> i64 {
        let m = grid.len();
        let n = grid[0].len();
        let mut sum = 0;
        for i in 0..m {
            for j in 0..n {
                sum += grid[i][j] as i64;
            }
        }
        if sum % 2 != 0 {
            return 0;
        }

        let target = sum / 2;
        let mut count = 0;

        for r1 in 0..m {
            for c1 in 0..n {
                for r2 in r1..m {
                    for c2 in if r1 == r2 { c1..n } else { 0..n } {
                        let mut current_sum = 0;
                        for i in 0..m {
                            for j in 0..n {
                                if (i < r1) || (i == r1 && j < c1) {
                                    current_sum += grid[i][j] as i64;
                                } else if (i > r2) || (i == r2 && j > c2) {
                                    current_sum += grid[i][j] as i64;
                                }
                            }
                        }

                        if current_sum == target {
                            count += 1;
                        }
                    }
                }
            }
        }

        count
    }
}

struct Solution;