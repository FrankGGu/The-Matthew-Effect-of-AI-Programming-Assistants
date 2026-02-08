impl Solution {
    pub fn check_valid(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();

        for i in 0..n {
            let mut seen_in_row = vec![false; n + 1];
            for j in 0..n {
                let val = grid[i][j];
                if val < 1 || val > n as i32 || seen_in_row[val as usize] {
                    return false;
                }
                seen_in_row[val as usize] = true;
            }
        }

        for j in 0..n {
            let mut seen_in_col = vec![false; n + 1];
            for i in 0..n {
                let val = grid[i][j];
                if val < 1 || val > n as i32 || seen_in_col[val as usize] {
                    return false;
                }
                seen_in_col[val as usize] = true;
            }
        }

        true
    }
}