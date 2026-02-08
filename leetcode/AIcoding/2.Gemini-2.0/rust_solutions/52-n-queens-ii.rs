impl Solution {
    pub fn total_n_queens(n: i32) -> i32 {
        let n = n as usize;
        let mut count = 0;
        let mut cols: Vec<bool> = vec![false; n];
        let mut diag1: Vec<bool> = vec![false; 2 * n - 1];
        let mut diag2: Vec<bool> = vec![false; 2 * n - 1];

        fn solve(row: usize, n: usize, cols: &mut Vec<bool>, diag1: &mut Vec<bool>, diag2: &mut Vec<bool>, count: &mut i32) {
            if row == n {
                *count += 1;
                return;
            }

            for col in 0..n {
                if !cols[col] && !diag1[row + col] && !diag2[row + n - 1 - col] {
                    cols[col] = true;
                    diag1[row + col] = true;
                    diag2[row + n - 1 - col] = true;
                    solve(row + 1, n, cols, diag1, diag2, count);
                    cols[col] = false;
                    diag1[row + col] = false;
                    diag2[row + n - 1 - col] = false;
                }
            }
        }

        solve(0, n, &mut cols, &mut diag1, &mut diag2, &mut count);
        count
    }
}