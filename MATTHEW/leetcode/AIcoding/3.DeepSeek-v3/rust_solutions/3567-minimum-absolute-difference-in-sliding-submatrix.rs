use std::collections::BTreeSet;

impl Solution {
    pub fn min_difference(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        if m == 1 && n == 1 {
            return 0;
        }

        let mut min_diff = i32::MAX;

        for i in 0..m - 1 {
            for j in 0..n - 1 {
                let a = grid[i][j];
                let b = grid[i][j + 1];
                let c = grid[i + 1][j];
                let d = grid[i + 1][j + 1];

                let mut nums = vec![a, b, c, d];
                nums.sort();

                for k in 0..3 {
                    min_diff = min_diff.min(nums[k + 1] - nums[k]);
                }
            }
        }

        min_diff
    }
}