impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn solve_rhombus(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut max_sums = HashSet::new();

        for i in 0..m {
            for j in 0..n {
                max_sums.insert(grid[i][j]);
                for k in 1..=std::cmp::min(m - i, n - j) {
                    let mut sum = 0;
                    let mut x = i;
                    let mut y = j;
                    for _ in 0..k {
                        sum += grid[x][y];
                        x += 1;
                        y += 1;
                    }
                    x = i + k;
                    y = j;
                    for _ in 0..k {
                        sum += grid[x][y];
                        x -= 1;
                        y += 1;
                    }
                    x = i + k;
                    y = j + k;
                    for _ in 0..k {
                        sum += grid[x][y];
                        x -= 1;
                        y -= 1;
                    }
                    x = i;
                    y = j + k;
                    for _ in 0..k {
                        sum += grid[x][y];
                        x += 1;
                        y -= 1;
                    }
                    max_sums.insert(sum);
                }
            }
        }

        let mut result: Vec<i32> = max_sums.into_iter().collect();
        result.sort_by(|a, b| b.cmp(a));
        if result.len() >= 3 {
            result[0] + result[1] + result[2]
        } else {
            result.iter().sum()
        }
    }
}
}