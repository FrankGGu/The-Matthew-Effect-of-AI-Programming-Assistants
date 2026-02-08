impl Solution {
    pub fn total_n_queens(n: i32) -> i32 {
        let mut count = 0;
        let mut queens = vec![-1; n as usize];
        Self::backtrack(&mut queens, 0, &mut count);
        count
    }

    fn backtrack(queens: &mut Vec<i32>, row: usize, count: &mut i32) {
        let n = queens.len();
        if row == n {
            *count += 1;
            return;
        }

        for col in 0..n {
            if Self::is_valid(queens, row, col as i32) {
                queens[row] = col as i32;
                Self::backtrack(queens, row + 1, count);
                queens[row] = -1;
            }
        }
    }

    fn is_valid(queens: &[i32], row: usize, col: i32) -> bool {
        for i in 0..row {
            if queens[i] == col || (row - i) as i32 == (queens[i] - col).abs() {
                return false;
            }
        }
        true
    }
}