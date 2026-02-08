impl Solution {
    pub fn largest1_bordered_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut horz = vec![vec![0; n + 1]; m];
        let mut vert = vec![vec![0; n]; m + 1];

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    horz[i][j + 1] = horz[i][j] + 1;
                    vert[i + 1][j] = vert[i][j] + 1;
                }
            }
        }

        let mut max_len = 0;
        for i in 0..m {
            for j in 0..n {
                let mut len = std::cmp::min(m - i, n - j);
                while len > max_len {
                    if horz[i][j + len] - horz[i][j] == len as i32 &&
                       horz[i + len - 1][j + len] - horz[i + len - 1][j] == len as i32 &&
                       vert[i + len][j] - vert[i][j] == len as i32 &&
                       vert[i + len][j + len - 1] - vert[i][j + len - 1] == len as i32 {
                        max_len = len;
                        break;
                    }
                    len -= 1;
                }
            }
        }

        (max_len * max_len) as i32
    }
}