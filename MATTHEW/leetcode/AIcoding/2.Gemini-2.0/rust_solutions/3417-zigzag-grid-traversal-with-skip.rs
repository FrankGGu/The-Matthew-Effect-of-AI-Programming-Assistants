impl Solution {
    pub fn zigzag_skip(matrix: Vec<Vec<i32>>, rows: i32, cols: i32, row: i32, col: i32, skip: i32) -> i32 {
        let mut r = row as i32;
        let mut c = col as i32;
        let m = rows as i32;
        let n = cols as i32;
        let mut skipped = 0;

        loop {
            if r >= 0 && r < m && c >= 0 && c < n {
                if skipped == skip {
                    return matrix[r as usize][c as usize];
                }
                skipped += 1;
            }

            if (r + c) % 2 == 0 {
                if c == n - 1 {
                    r += 1;
                } else {
                    r -= 1;
                    c += 1;
                }
            } else {
                if r == m - 1 {
                    c += 1;
                } else {
                    r += 1;
                    c -= 1;
                }
            }

            if r < 0 && c < n {
                r = 0;
            } else if c < 0 && r < m {
                c = 0;
            } else if r >= m && c < n {
                r = m - 1;
                c += 2;
            } else if c >= n && r < m {
                c = n - 1;
                r += 2;
            } else if r >= m && c >= n {
                return -1;
            } else if r < 0 && c >= n {
                return -1;
            }
        }
    }
}