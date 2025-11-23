impl Solution {

use std::cmp::max;

struct Solution {}

impl Solution {
    pub fn maximum_happiness(mut n: i32, mut m: i32, mut k: i32) -> i32 {
        let mut grid = vec![vec![0; m as usize]; n as usize];
        let mut res = 0;
        for i in 0..n as usize {
            for j in 0..m as usize {
                if k > 0 {
                    grid[i][j] = 1;
                    k -= 1;
                    res += 1;
                    if i > 0 {
                        res += grid[i - 1][j];
                    }
                    if j > 0 {
                        res += grid[i][j - 1];
                    }
                    if i > 0 && j > 0 {
                        res -= grid[i - 1][j - 1];
                    }
                }
            }
        }
        res
    }
}
}