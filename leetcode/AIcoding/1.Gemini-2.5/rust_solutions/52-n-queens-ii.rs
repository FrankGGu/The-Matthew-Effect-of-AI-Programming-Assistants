impl Solution {
    pub fn total_n_queens(n: i32) -> i32 {
        let mut count = 0;
        let mut cols = vec![false; n as usize];
        let mut diag1 = vec![false; (2 * n - 1) as usize];
        let mut diag2 = vec![false; (2 * n - 1) as usize];

        Self::solve(n, 0, &mut count, &mut cols, &mut diag1, &mut diag2);

        count
    }

    fn solve(
        n: i32,
        row: i32,
        count: &mut i32,
        cols: &mut Vec<bool>,
        diag1: &mut Vec<bool>,
        diag2: &mut Vec<bool>,
    ) {
        if row == n {
            *count += 1;
            return;
        }

        for col in 0..n {
            let d1_idx = (row - col + n - 1) as usize;
            let d2_idx = (row + col) as usize;

            if !cols[col as usize] && !diag1[d1_idx] && !diag2[d2_idx] {
                cols[col as usize] = true;
                diag1[d1_idx] = true;
                diag2[d2_idx] = true;

                Self::solve(n, row + 1, count, cols, diag1, diag2);

                cols[col as usize] = false;
                diag1[d1_idx] = false;
                diag2[d2_idx] = false;
            }
        }
    }
}