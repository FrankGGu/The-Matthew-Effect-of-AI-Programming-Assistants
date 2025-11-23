impl Solution {
    pub fn surface_area(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut area = 0;

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] > 0 {
                    area += 2;
                    area += if i == 0 { grid[i][j] } else { std::cmp::max(0, grid[i][j] - grid[i - 1][j]) };
                    area += if i == n - 1 { grid[i][j] } else { std::cmp::max(0, grid[i][j] - grid[i + 1][j]) };
                    area += if j == 0 { grid[i][j] } else { std::cmp::max(0, grid[i][j] - grid[i][j - 1]) };
                    area += if j == n - 1 { grid[i][j] } else { std::cmp::max(0, grid[i][j] - grid[i][j + 1]) };
                }
            }
        }

        area
    }
}