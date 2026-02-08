impl Solution {
    pub fn max_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut min_prefix = grid.clone();

        for j in 1..n {
            min_prefix[0][j] = min_prefix[0][j].min(min_prefix[0][j - 1]);
        }

        for i in 1..m {
            min_prefix[i][0] = min_prefix[i][0].min(min_prefix[i - 1][0]);
        }

        for i in 1..m {
            for j in 1..n {
                min_prefix[i][j] = min_prefix[i][j].min(min_prefix[i - 1][j].min(min_prefix[i][j - 1]));
            }
        }

        let mut max_score = i32::MIN;

        for r in 1..m {
            for c in 1..n {
                let min_val_in_prefix_excluding_rc = min_prefix[r - 1][c].min(min_prefix[r][c - 1]);
                let current_score = grid[r][c] - min_val_in_prefix_excluding_rc;
                max_score = max_score.max(current_score);
            }
        }

        max_score
    }
}