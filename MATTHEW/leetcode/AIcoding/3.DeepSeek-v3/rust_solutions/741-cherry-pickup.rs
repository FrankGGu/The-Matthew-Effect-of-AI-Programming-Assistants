impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut dp = vec![vec![vec![-1; n]; n];
        dp[0][0][0] = grid[0][0];

        for t in 1..2*n-1 {
            let mut dp2 = vec![vec![vec![-1; n]; n];
            for i in 0..n {
                for j in 0..n {
                    let k = t as i32 - i as i32;
                    let l = t as i32 - j as i32;
                    if k < 0 || k >= n as i32 || l < 0 || l >= n as i32 {
                        continue;
                    }
                    let k = k as usize;
                    let l = l as usize;
                    if grid[i][k] == -1 || grid[j][l] == -1 {
                        continue;
                    }
                    let mut val = grid[i][k];
                    if i != j || k != l {
                        val += grid[j][l];
                    }
                    let mut max = -1;
                    for a in i.saturating_sub(1)..=i {
                        for b in j.saturating_sub(1)..=j {
                            if a < n && b < n && dp[a][b][k] > max {
                                max = dp[a][b][k];
                            }
                        }
                    }
                    for c in k.saturating_sub(1)..=k {
                        for d in l.saturating_sub(1)..=l {
                            if c < n && d < n && dp[i][j][c] > max {
                                max = dp[i][j][c];
                            }
                        }
                    }
                    if max != -1 {
                        dp2[i][j][k] = max + val;
                    }
                }
            }
            dp = dp2;
        }
        dp[n-1][n-1][n-1].max(0)
    }
}