impl Solution {
    pub fn num_magic_squares_inside(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut count = 0;

        for i in 0..m - 2 {
            for j in 0..n - 2 {
                if Solution::is_magic_square(&grid, i, j) {
                    count += 1;
                }
            }
        }

        count
    }

    fn is_magic_square(grid: &Vec<Vec<i32>>, row: usize, col: usize) -> bool {
        let mut nums = [0; 10];
        for i in row..row + 3 {
            for j in col..col + 3 {
                let num = grid[i][j];
                if num < 1 || num > 9 || nums[num as usize] == 1 {
                    return false;
                }
                nums[num as usize] = 1;
            }
        }

        let sum = grid[row][col] + grid[row][col + 1] + grid[row][col + 2];

        if grid[row + 1][col] + grid[row + 1][col + 1] + grid[row + 1][col + 2] != sum {
            return false;
        }
        if grid[row + 2][col] + grid[row + 2][col + 1] + grid[row + 2][col + 2] != sum {
            return false;
        }
        if grid[row][col] + grid[row + 1][col] + grid[row + 2][col] != sum {
            return false;
        }
        if grid[row][col + 1] + grid[row + 1][col + 1] + grid[row + 2][col + 1] != sum {
            return false;
        }
        if grid[row][col + 2] + grid[row + 1][col + 2] + grid[row + 2][col + 2] != sum {
            return false;
        }
        if grid[row][col] + grid[row + 1][col + 1] + grid[row + 2][col + 2] != sum {
            return false;
        }
        if grid[row][col + 2] + grid[row + 1][col + 1] + grid[row + 2][col] != sum {
            return false;
        }

        true
    }
}