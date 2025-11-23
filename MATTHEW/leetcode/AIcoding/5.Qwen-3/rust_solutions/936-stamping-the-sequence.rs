struct Solution;

impl Solution {
    pub fn possible_to_stamp(mut grid: Vec<Vec<char>>, h: i32, w: i32) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut stamp = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 'X' {
                    continue;
                }
                if i + h as usize <= m && j + w as usize <= n {
                    stamp[i][j] += 1;
                    if i + h as usize < m {
                        stamp[i + h as usize][j] -= 1;
                    }
                    if j + w as usize < n {
                        stamp[i][j + w as usize] -= 1;
                    }
                    if i + h as usize < m && j + w as usize < n {
                        stamp[i + h as usize][j + w as usize] += 1;
                    }
                }
            }
        }

        for i in 0..m {
            for j in 1..n {
                stamp[i][j] += stamp[i][j - 1];
            }
        }

        for j in 0..n {
            for i in 1..m {
                stamp[i][j] += stamp[i - 1][j];
            }
        }

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 'X' {
                    continue;
                }
                let x = i as i32 + h;
                let y = j as i32 + w;
                if x > m as i32 || y > n as i32 {
                    return false;
                }
                let count = stamp[i as usize][j as usize];
                if count == 0 {
                    return false;
                }
            }
        }

        true
    }
}