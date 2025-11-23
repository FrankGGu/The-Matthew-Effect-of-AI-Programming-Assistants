impl Solution {
    pub fn matrix_score(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let rows = grid.len();
        let cols = grid[0].len();

        // Flip rows to make the first element 1
        for i in 0..rows {
            if grid[i][0] == 0 {
                for j in 0..cols {
                    grid[i][j] ^= 1;
                }
            }
        }

        // Flip columns to maximize the number of 1s
        for j in 1..cols {
            let count = grid.iter().filter(|&&row| row[j] == 1).count();
            if count < rows - count {
                for i in 0..rows {
                    grid[i][j] ^= 1;
                }
            }
        }

        // Calculate the score
        let mut score = 0;
        for i in 0..rows {
            for j in 0..cols {
                score += grid[i][j] << (cols - 1 - j);
            }
        }

        score
    }
}