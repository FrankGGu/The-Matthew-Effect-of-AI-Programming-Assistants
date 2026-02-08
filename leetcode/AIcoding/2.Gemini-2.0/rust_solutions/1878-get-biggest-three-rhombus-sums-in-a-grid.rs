use std::collections::HashSet;

impl Solution {
    pub fn get_biggest_three(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let m = grid.len();
        let n = grid[0].len();
        let mut sums = HashSet::new();

        for r in 0..m {
            for c in 0..n {
                sums.insert(grid[r][c]);

                for k in 1..=(m.min(n)) {
                    if r - k >= 0 && r + k < m && c - k >= 0 && c + k < n {
                        let mut sum = 0;
                        for i in 0..k {
                            sum += grid[r - i][c - k + i];
                            sum += grid[r - i][c + k - i];
                            sum += grid[r + i][c - k + i];
                            sum += grid[r + i][c + k - i];
                        }
                        sum += grid[r - k][c];
                        sum += grid[r + k][c];
                        sum += grid[r][c - k];
                        sum += grid[r][c + k];

                        sums.insert(sum);
                    }
                }
            }
        }

        let mut result: Vec<i32> = sums.into_iter().collect();
        result.sort_by(|a, b| b.cmp(a));
        result.truncate(3);
        result
    }
}