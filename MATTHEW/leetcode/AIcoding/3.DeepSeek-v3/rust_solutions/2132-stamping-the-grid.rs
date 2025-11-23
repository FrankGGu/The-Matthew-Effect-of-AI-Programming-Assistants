impl Solution {
    pub fn possible_to_stamp(grid: Vec<Vec<i32>>, stamp_height: i32, stamp_width: i32) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut prefix = vec![vec![0; n + 1]; m + 1];
        for i in 0..m {
            for j in 0..n {
                prefix[i + 1][j + 1] = grid[i][j] + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j];
            }
        }

        let mut diff = vec![vec![0; n + 2]; m + 2];
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    continue;
                }
                let x = i + stamp_height as usize;
                let y = j + stamp_width as usize;
                if x > m || y > n {
                    continue;
                }
                let sum = prefix[x][y] - prefix[i][y] - prefix[x][j] + prefix[i][j];
                if sum == 0 {
                    diff[i + 1][j + 1] += 1;
                    diff[i + 1][y + 1] -= 1;
                    diff[x + 1][j + 1] -= 1;
                    diff[x + 1][y + 1] += 1;
                }
            }
        }

        let mut count = vec![vec![0; n + 1]; m + 1];
        for i in 1..=m {
            for j in 1..=n {
                count[i][j] = count[i - 1][j] + count[i][j - 1] - count[i - 1][j - 1] + diff[i][j];
                if grid[i - 1][j - 1] == 0 && count[i][j] == 0 {
                    return false;
                }
            }
        }
        true
    }
}