impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn ways(cheese: Vec<Vec<char>>) -> i32 {
        let m = cheese.len();
        let n = cheese[0].len();
        let mut dp = vec![vec![vec![-1; n]; m]; m];
        let mut prefix = vec![vec![0; n + 1]; m + 1];

        for i in 0..m {
            for j in 0..n {
                prefix[i + 1][j + 1] = cheese[i][j] as i32 + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j];
            }
        }

        fn has_cheese(prefix: &Vec<Vec<i32>>, r1: usize, c1: usize, r2: usize, c2: usize) -> bool {
            prefix[r2][c2] - prefix[r1][c2] - prefix[r2][c1] + prefix[r1][c1] > 0
        }

        fn dfs(
            prefix: &Vec<Vec<i32>>,
            dp: &mut Vec<Vec<Vec<i32>>>,
            m: usize,
            n: usize,
            r: usize,
            c: usize,
        ) -> i32 {
            if dp[r][c][n] != -1 {
                return dp[r][c][n];
            }
            let mut res = 0;
            for i in r + 1..m {
                if has_cheese(prefix, r, c, i, n) && has_cheese(prefix, i, c, m, n) {
                    res += dfs(prefix, dp, m, n, i, c);
                }
            }
            for j in c + 1..n {
                if has_cheese(prefix, r, c, m, j) && has_cheese(prefix, r, j, m, n) {
                    res += dfs(prefix, dp, m, n, r, j);
                }
            }
            dp[r][c][n] = res;
            res
        }

        dfs(&prefix, &mut dp, m, n, 0, 0)
    }
}
}