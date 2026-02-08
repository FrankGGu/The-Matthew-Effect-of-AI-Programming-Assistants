impl Solution {
    pub fn possible_to_stamp(grid: Vec<Vec<i32>>, stamp_height: i32, stamp_width: i32) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let sh = stamp_height as usize;
        let sw = stamp_width as usize;

        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];
        for i in 0..m {
            for j in 0..n {
                prefix_sum[i + 1][j + 1] = prefix_sum[i + 1][j] + prefix_sum[i][j + 1] - prefix_sum[i][j] + grid[i][j];
            }
        }

        let mut diff = vec![vec![0; n]; m];
        for i in 0..=m - sh {
            for j in 0..=n - sw {
                let sum = prefix_sum[i + sh][j + sw] - prefix_sum[i + sh][j] - prefix_sum[i][j + sw] + prefix_sum[i][j];
                if sum == 0 {
                    diff[i][j] += 1;
                    if i + sh < m {
                        diff[i + sh][j] -= 1;
                    }
                    if j + sw < n {
                        diff[i][j + sw] -= 1;
                    }
                    if i + sh < m && j + sw < n {
                        diff[i + sh][j + sw] += 1;
                    }
                }
            }
        }

        let mut stamped = vec![vec![0; n]; m];
        for i in 0..m {
            for j in 0..n {
                if i > 0 {
                    diff[i][j] += diff[i - 1][j];
                    stamped[i][j] += stamped[i - 1][j];
                }
                if j > 0 {
                    diff[i][j] += diff[i][j - 1];
                    stamped[i][j] += stamped[i][j - 1];
                }
                if i > 0 && j > 0 {
                    diff[i][j] -= diff[i - 1][j - 1];
                    stamped[i][j] -= stamped[i - 1][j - 1];
                }
                stamped[i][j] += diff[i][j];
            }
        }

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 && stamped[i][j] == 0 {
                    return false;
                }
            }
        }

        true
    }
}