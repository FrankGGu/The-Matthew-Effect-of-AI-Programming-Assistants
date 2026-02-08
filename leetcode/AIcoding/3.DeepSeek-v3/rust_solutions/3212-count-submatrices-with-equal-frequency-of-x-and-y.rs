impl Solution {
    pub fn count_submatrices_with_equal_frequency_of_x_and_y(grid: Vec<Vec<i32>>, x: i32, y: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut prefix = vec![vec![0; n + 1]; m + 1];
        let mut count = 0;

        for i in 1..=m {
            for j in 1..=n {
                prefix[i][j] = prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
                if grid[i - 1][j - 1] == x {
                    prefix[i][j] += 1;
                } else if grid[i - 1][j - 1] == y {
                    prefix[i][j] -= 1;
                }
            }
        }

        for i in 1..=m {
            for j in 1..=n {
                for k in 1..=i {
                    for l in 1..=j {
                        let sum = prefix[i][j] - prefix[k - 1][j] - prefix[i][l - 1] + prefix[k - 1][l - 1];
                        if sum == 0 {
                            count += 1;
                        }
                    }
                }
            }
        }

        count
    }
}