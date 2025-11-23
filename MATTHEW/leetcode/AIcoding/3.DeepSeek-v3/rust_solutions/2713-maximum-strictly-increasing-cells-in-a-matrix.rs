use std::collections::{HashMap, BTreeMap};

impl Solution {
    pub fn max_increasing_cells(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut value_positions: BTreeMap<i32, Vec<(usize, usize)>> = BTreeMap::new();

        for i in 0..m {
            for j in 0..n {
                let val = mat[i][j];
                value_positions.entry(val).or_default().push((i, j));
            }
        }

        let mut row_max = vec![0; m];
        let mut col_max = vec![0; n];
        let mut dp = vec![vec![0; n]; m];
        let mut res = 0;

        for (val, positions) in value_positions {
            let mut updates = Vec::new();
            for &(i, j) in &positions {
                let max = row_max[i].max(col_max[j]) + 1;
                updates.push((i, j, max));
                res = res.max(max);
            }
            for (i, j, max) in updates {
                dp[i][j] = max;
            }
            for &(i, j) in &positions {
                row_max[i] = row_max[i].max(dp[i][j]);
                col_max[j] = col_max[j].max(dp[i][j]);
            }
        }

        res
    }
}