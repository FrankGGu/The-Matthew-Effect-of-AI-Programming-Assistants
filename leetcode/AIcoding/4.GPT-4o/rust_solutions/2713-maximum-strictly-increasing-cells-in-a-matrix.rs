use std::collections::HashMap;

impl Solution {
    pub fn max_increasing_cells(mat: Vec<Vec<i32>>) -> i32 {
        let n = mat.len();
        let m = mat[0].len();
        let mut positions = vec![vec![]; 1001];

        for i in 0..n {
            for j in 0..m {
                positions[mat[i][j] as usize].push((i, j));
            }
        }

        let mut dp = vec![vec![1; m]; n];
        let mut result = 1;

        for value in 1..1001 {
            for &(x, y) in &positions[value as usize] {
                for i in 0..n {
                    if mat[i][y] < value {
                        dp[x][y] = dp[x][y].max(dp[i][y] + 1);
                    }
                }

                for j in 0..m {
                    if mat[x][j] < value {
                        dp[x][y] = dp[x][y].max(dp[x][j] + 1);
                    }
                }

                result = result.max(dp[x][y]);
            }
        }

        result
    }
}