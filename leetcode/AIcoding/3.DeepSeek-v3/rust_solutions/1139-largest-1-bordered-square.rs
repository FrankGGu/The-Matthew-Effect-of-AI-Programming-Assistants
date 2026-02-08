impl Solution {
    pub fn largest1_bordered_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        let mut left = vec![vec![0; n]; m];
        let mut top = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    left[i][j] = if j > 0 { left[i][j - 1] + 1 } else { 1 };
                    top[i][j] = if i > 0 { top[i - 1][j] + 1 } else { 1 };
                }
            }
        }

        let mut max_len = 0;
        for i in 0..m {
            for j in 0..n {
                let mut len = std::cmp::min(left[i][j], top[i][j]);
                while len > max_len {
                    let k = len as usize;
                    if i >= k - 1 && j >= k - 1 && 
                       left[i - k + 1][j] >= len && 
                       top[i][j - k + 1] >= len {
                        max_len = len;
                        break;
                    }
                    len -= 1;
                }
            }
        }
        max_len * max_len
    }
}