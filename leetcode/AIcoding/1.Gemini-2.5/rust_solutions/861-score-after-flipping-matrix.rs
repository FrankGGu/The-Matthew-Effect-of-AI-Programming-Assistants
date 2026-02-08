impl Solution {
    pub fn matrix_score(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        for i in 0..m {
            if grid[i][0] == 0 {
                for j in 0..n {
                    grid[i][j] = 1 - grid[i][j];
                }
            }
        }

        let mut total_score = 0;

        total_score += (1 << (n - 1)) * m as i32;

        for j in 1..n {
            let mut ones_count = 0;
            for i in 0..m {
                if grid[i][j] == 1 {
                    ones_count += 1;
                }
            }

            let effective_ones = ones_count.max(m as i32 - ones_count);

            total_score += effective_ones * (1 << (n - 1 - j));
        }

        total_score
    }
}