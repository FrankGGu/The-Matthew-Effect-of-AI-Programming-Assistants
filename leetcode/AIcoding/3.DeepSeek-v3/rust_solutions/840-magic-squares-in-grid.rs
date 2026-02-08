impl Solution {
    pub fn num_magic_squares_inside(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows < 3 {
            return 0;
        }
        let cols = grid[0].len();
        if cols < 3 {
            return 0;
        }

        let mut count = 0;

        for i in 0..rows - 2 {
            for j in 0..cols - 2 {
                let mut nums = vec![false; 10];
                let mut valid = true;

                for x in 0..3 {
                    for y in 0..3 {
                        let num = grid[i + x][j + y];
                        if num < 1 || num > 9 || nums[num as usize] {
                            valid = false;
                            break;
                        }
                        nums[num as usize] = true;
                    }
                    if !valid {
                        break;
                    }
                }
                if !valid {
                    continue;
                }

                let r1 = grid[i][j] + grid[i][j + 1] + grid[i][j + 2];
                let r2 = grid[i + 1][j] + grid[i + 1][j + 1] + grid[i + 1][j + 2];
                let r3 = grid[i + 2][j] + grid[i + 2][j + 1] + grid[i + 2][j + 2];

                let c1 = grid[i][j] + grid[i + 1][j] + grid[i + 2][j];
                let c2 = grid[i][j + 1] + grid[i + 1][j + 1] + grid[i + 2][j + 1];
                let c3 = grid[i][j + 2] + grid[i + 1][j + 2] + grid[i + 2][j + 2];

                let d1 = grid[i][j] + grid[i + 1][j + 1] + grid[i + 2][j + 2];
                let d2 = grid[i][j + 2] + grid[i + 1][j + 1] + grid[i + 2][j];

                if r1 == r2 && r2 == r3 && r3 == c1 && c1 == c2 && c2 == c3 && c3 == d1 && d1 == d2 {
                    count += 1;
                }
            }
        }

        count
    }
}