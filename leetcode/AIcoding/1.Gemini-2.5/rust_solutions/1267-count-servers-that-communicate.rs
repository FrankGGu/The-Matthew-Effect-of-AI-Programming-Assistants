impl Solution {
    pub fn count_servers(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        let mut row_counts = vec![0; m];
        let mut col_counts = vec![0; n];

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    row_counts[r] += 1;
                    col_counts[c] += 1;
                }
            }
        }

        let mut communicating_servers = 0;
        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    if row_counts[r] > 1 || col_counts[c] > 1 {
                        communicating_servers += 1;
                    }
                }
            }
        }

        communicating_servers
    }
}