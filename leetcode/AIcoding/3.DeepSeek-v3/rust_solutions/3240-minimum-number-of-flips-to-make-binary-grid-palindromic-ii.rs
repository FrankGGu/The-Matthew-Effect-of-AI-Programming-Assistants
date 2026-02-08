impl Solution {
    pub fn min_flips(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut flips = 0;

        for i in 0..n / 2 {
            for j in 0..n / 2 {
                let a = grid[i][j];
                let b = grid[i][n - 1 - j];
                let c = grid[n - 1 - i][j];
                let d = grid[n - 1 - i][n - 1 - j];

                let sum = a + b + c + d;
                flips += std::cmp::min(sum, 4 - sum);
            }
        }

        if n % 2 == 1 {
            let mid = n / 2;
            for j in 0..n / 2 {
                let a = grid[mid][j];
                let b = grid[mid][n - 1 - j];

                if a != b {
                    flips += 1;
                }
            }
        }

        flips
    }
}