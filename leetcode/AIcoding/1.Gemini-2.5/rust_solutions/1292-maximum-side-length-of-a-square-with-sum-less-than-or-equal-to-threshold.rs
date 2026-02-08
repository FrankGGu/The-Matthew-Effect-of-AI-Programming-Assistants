impl Solution {
    fn check(k: i32, rows: usize, cols: usize, threshold: i32, ps: &Vec<Vec<i32>>) -> bool {
        if k == 0 {
            return true;
        }
        let k_usize = k as usize;
        if k_usize > rows || k_usize > cols {
            return false;
        }

        for r1 in 0..=(rows - k_usize) {
            for c1 in 0..=(cols - k_usize) {
                let r2 = r1 + k_usize - 1;
                let c2 = c1 + k_usize - 1;
                let current_sum = ps[r2 + 1][c2 + 1] - ps[r1][c2 + 1] - ps[r2 + 1][c1] + ps[r1][c1];
                if current_sum <= threshold {
                    return true;
                }
            }
        }
        false
    }

    pub fn max_side_length(grid: Vec<Vec<i32>>, threshold: i32) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let mut ps = vec![vec![0; cols + 1]; rows + 1];
        for r in 0..rows {
            for c in 0..cols {
                ps[r + 1][c + 1] = grid[r][c] + ps[r][c + 1] + ps[r + 1][c] - ps[r][c];
            }
        }

        let mut low = 0;
        let mut high = std::cmp::min(rows, cols) as i32;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, rows, cols, threshold, &ps) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }
}